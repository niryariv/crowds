class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.xml
  
  # before_filter :require_user, :only => [:create, :destroy]
  before_filter :signin_required, :only => [:create, :destroy]
  after_filter :store_location, :only => [:create]
  
  def index
    @crowd = Crowd.find(params[:crowd_id])
    @feeds = @crowd.feeds #Feeds.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  # index.xml.builder
    end
  end


  # POST /feeds
  # POST /feeds.xml
  def create
    crowd = Crowd.find(params[:crowd_id])
    
    raise "unauthorized" unless current_user.owns?(crowd)
    
    url_param = params[:feed] ? params[:feed][:url] : params[:url]
    unless url_param.blank?
      url = url_param.strip.gsub(/^https/i, 'http') # open-uri can't handle SSL, so attempt to get the feed from the http address
      new_f = crowd.add_feed_from_url(url)
      raise "cant_save_url" unless new_f
    else # import OPML
      new_feed_count = 0
      raise "no_opml" if params[:feed].nil?

      doc = REXML::Document.new(params[:feed][:opml].read)
      doc.root.each_element('//outline') do |e| 
        title = e.attributes['title']
        title = e.attributes['text'] if title.nil?
        xmlUrl = e.attributes['xmlUrl'].to_s.gsub(/^https/, 'http') # open-uri can't handle SSL, so attempt to get the feed from the http address
        htmlUrl = e.attributes['htmlUrl'].to_s.gsub(/^https/, 'http')

        unless xmlUrl == '' or title == ''
          new_feed_count += 1 if crowd.add_feed({:url=>xmlUrl, :home_url=>htmlUrl, :title=>title})
        end
        
      end
    end

    respond_to do |format|
      format.html { 
        flash[:notice] = url_param ? "Added feed: '#{new_f.title}'" : "Imported #{new_feed_count} feeds"
        redirect_to crowd_feeds_path(crowd) 
      }
      format.xml  { render :xml => crowd.feeds, :status => :created }
    end
    
  rescue Exception => e
    logger.error "IMPORT ERROR: #{e.message} #{e.to_yaml}"
    respond_to do |format|
      format.html { 
        flash[:notice] = case e.message
          when 'cant_save_url': "Cannot find feed for: '#{url}'"
          when 'unauthorized' : "Sorry, you're not allowed to edit this crowd"
          when 'no_opml'      : "No OPML file to upload"
          else "Can't import this file - are you sure this is OPML?"
        end
        redirect_to crowd_feeds_path(crowd) 
      }
      format.xml  { render :xml => crowd.feeds, :status => :created }
   end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.xml
  def destroy
    # Removes ownership only, the feed stays in the DB. See README_FOR_APP
    o = current_user.ownerships.find_by_feed_id(params[:id])
    crowd = params[:crowd_id]
    if o.nil?
      flash[:notice] = "Not allowed to delete this."
    else
      flash[:notice] = "Deleted #{o.feed.title} (<a href=\"/crowd/#{crowd}/import?url=#{CGI::escape(o.feed.url)}\">Undo</a>)"
      Ownership.delete_all(["crowd_id = ? and feed_id = ?", params[:crowd_id], params[:id]])
      Item.delete_all(["feed_id = ?", params[:id]])
    end

    respond_to do |format|
      format.html { redirect_to(crowd_feeds_url(crowd)) }
      format.xml  { head :ok }
    end
  end

# private
#   def import_opml(crowd)
#     crowd = Crowd.find(params[:crowd])
# 
#     doc = REXML::Document.new(params[:opml_file].read)
#     doc.root.each_element('//outline') do |e| 
#       title = e.attributes['title']
#       title = e.attributes['text'] if title.nil?
#       xmlUrl = e.attributes['xmlUrl'].to_s.gsub(/^https/, 'http') # open-uri can't handle SSL, so attempt to get the feed from the http address
#       htmlUrl = e.attributes['htmlUrl'].to_s.gsub(/^https/, 'http')
# 
#       crowd.add_feed({:url=>xmlUrl, :home_url=>htmlUrl, :title=>title}) unless xmlUrl == ''
#     end
# 
#     redirect_to :controller=>'crowds', :action=>'feeds', :id=>crowd
#   rescue Exception => e
#     flash[:notice] = "Cannot parse OPML file"
#     logger.info "OPML PARSE ERROR: #{e.message}"
#   end
    
  # # GET /feeds/1
  # # GET /feeds/1.xml
  # def show
  #   @feeds = Feeds.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @feeds }
  #   end
  # end

  # # GET /feeds/new
  # # GET /feeds/new.xml
  # def new
  #   @feeds = Feeds.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @feeds }
  #   end
  # end

  # # GET /feeds/1/edit
  # def edit
  #   @feeds = Feeds.find(params[:id])
  # end


  # # PUT /feeds/1
  # # PUT /feeds/1.xml
  # def update
  #   @feeds = Feeds.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @feeds.update_attributes(params[:feeds])
  #       flash[:notice] = 'Feeds was successfully updated.'
  #       format.html { redirect_to(@feeds) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @feeds.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

end
