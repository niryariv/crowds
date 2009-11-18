class CrowdsController < ApplicationController
  
  # before_filter :require_user, :except => :index
  before_filter :signin_required, :except => :index

  # GET /crowds
  # GET /crowds.xml
  def index
    if current_user
      @crowds = current_user.crowds
      # logger.info "CROWDS: #{@crowds}"
      # if @crowds.size == 1
      #   redirect_to crowd_items_url(@crowds.first) #:action=>:items, :id=>current_user.crowds.first
      # else        
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
        format.html { redirect_to crowd_feeds_path(@crowd) } #redirect_to(@crowds) }
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
    if current_user.crowds.include?(crowds) and crowd.destroy
      flash[:notice] = "Crowd Deleted"
    else 
      flash[:notice] = "Can't touch this"
    end

    respond_to do |format|
      format.html { redirect_to(crowds_url) }
      format.xml  { head :ok }
    end
  end


  # # PUT /crowds/1
  # # PUT /crowds/1.xml
  # def update
  #   @crowds = Crowds.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @crowds.update_attributes(params[:crowds])
  #       flash[:notice] = 'Crowds was successfully updated.'
  #       format.html { redirect_to(@crowds) }
  #       format.xml  { head :ok }
  #     else
  #       format.html { render :action => "edit" }
  #       format.xml  { render :xml => @crowds.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

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
