class CrowdsController < ApplicationController
  
  # before_filter :require_user, :except => :index
  before_filter :signin_required, :except => :index

  # GET /crowds
  # GET /crowds.xml
  def index
    if current_user
      @crowds = current_user.crowds.all(:conditions => {:delete_at => nil})
      @deleted_crowds = current_user.crowds.all(:conditions => ['delete_at > 1'])
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @crowds }
      end
      # end
    end
  end
    
  
  # POST /crowds
  # POST /crowds.xml
  def create
    p = params[:crowd]
    @crowd = Crowd.new(:title => p[:title].strip, :user_id => current_user.id)

    respond_to do |format|
      if @crowd.save
        format.html { redirect_to crowd_feeds_path(@crowd) }
        format.xml  { render :xml => @crowd, :status => :created, :location => @crowd }
      else
        format.html { render :action => :index }
        format.xml  { render :xml => @crowd.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /crowds/1
  # DELETE /crowds/1.xml
  def destroy
    crowd = Crowd.find(params[:id])
    if current_user.crowds.include?(crowd)
      crowd.delete_at = 1.week.from_now
      crowd.save
      flash[:notice] = "Removed #{crowd.title}."
    else 
      flash[:notice] = "Can't touch this"
    end

    respond_to do |format|
      format.html { redirect_to(crowds_url) }
      format.xml  { head :ok }
    end
  end


  # This only does Un-delete for now
  # PUT /crowds/1
  # PUT /crowds/1.xml
  def update
    crowd = Crowd.find(params[:id])
    crowd.delete_at = nil
    respond_to do |format|
      if crowd.save
        flash[:notice] = "Restored <b>#{crowd.title}</b>"
        format.html { redirect_to(crowds_url) }
        format.xml  { head :ok }
      else
        flash[:notice] = "Couldn't restore <b>#{crowd.title}</b> :("
        format.html { redirect_to(crowds_url) }
        format.xml  { render :xml => crowd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # # GET /crowds
  # # GET /crowds.xml
  # def index
  #   @crowds = current_user.crowds.find(:all)
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @crowds }
  #   end
  # end

  # # GET /crowds/1
  # # GET /crowds/1.xml
  # def show
  #   @crowds = Crowds.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @crowds }
  #   end
  # end

  # # GET /crowds/new
  # # GET /crowds/new.xml
  # def new
  #   @crowds = Crowds.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.xml  { render :xml => @crowds }
  #   end
  # end

  # # GET /crowds/1/edit
  # def edit
  #   @crowds = Crowds.find(params[:id])
  # end
end
