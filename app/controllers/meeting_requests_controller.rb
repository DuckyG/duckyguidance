class MeetingRequestsController < ApplicationController
  access_control do
    action :welcome, :welcome_submit do
      allow all
    end
    actions :index, :show, :past, :future do
      allow :counselor, :of => :current_school
      allow :superadmin
    end

    actions :new, :create do
      allow :counselor, :of => :current_school
      allow :school_admin, :of => :current_school
    end

    actions :edit, :update do
      allow :counselor, :of => :current_school
      allow :school_admin, :of => :current_school
    end

    action :destroy do
      allow :counselor, :of => :current_school
      allow :school_admin,:of => :current_school
    end
   end
   
  layout :choose_layout
  # GET /meeting_requests
  # GET /meeting_requests.xml
  def index
    @meeting_requests = MeetingRequest.for_school(current_school).all.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meeting_requests }
    end
  end

  # GET /meeting_requests/1
  # GET /meeting_requests/1.xml
  def show
    @meeting_request = MeetingRequest.for_school(current_school).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meeting_request }
    end
  end

  # GET /meeting_requests/new
  # GET /meeting_requests/new.xml
  def new
    @meeting_request = MeetingRequest.for_school(current_school).build
    @title = 'Request a Meeting'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting_request }
    end
  end
  
  def past
    @meeting_requests = MeetingRequest.for_school(current_school).past.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render :index}
      format.xml  { render :xml => @meeting_requests }
    end
  end
  
  def future
    @meeting_requests = MeetingRequest.for_school(current_school).future.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render :index}
      format.xml  { render :xml => @meeting_requests }
    end
  end
  
  def welcome
    new
  end
  
  def welcome_submit
    @meeting_request = MeetingRequest.for_school(current_school).build(params[:meeting_request])

    respond_to do |format|
      if @meeting_request.save!
        Notifier.delay.request_submitted(@meeting_request)
        Notifier.delay.request_received(@meeting_request)  
        format.html { redirect_to(thankyou_path, :notice => 'Your meeting request was received.  You should receive an email from one of the counselors shortly.') }
        format.xml  { render :xml => @meeting_request, :status => :created, :location => @meeting_request }
      else
        logger.info @meeting_request.errors.any?
        format.html { render :action => "welcome" }
        format.xml  { render :xml => @meeting_request.errors, :status => :unprocessable_entity }
      end
    end
  end
  # GET /meeting_requests/1/edit
  def edit
    @meeting_request = MeetingRequest.current_school.find(params[:id])
  end

  # POST /meeting_requests
  # POST /meeting_requests.xml
  def create
    @meeting_request = MeetingRequest.for_school(current_school).build(params[:meeting_request])
    @meeting_request.school = current_school
    respond_to do |format|
      if @meeting_request.save
        Notifier.delay.request_submitted(@meeting_request)
        Notifier.delay.request_received(@meeting_request)  
        format.html { redirect_to(thankyou_path, :notice => 'Your meeting request was received.  You should receive an email from one of the counselors shortly.') }
        format.xml  { render :xml => @meeting_request, :status => :created, :location => @meeting_request }
      else
        format.html { render :action => "welcome" }
        format.xml  { render :xml => @meeting_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_requests/1
  # PUT /meeting_requests/1.xml
  def update
    @meeting_request = current_school.meeting_requests.find(params[:id])
    params[:meeting_request] = {} unless params[:meeting_request]
    updated = false
    params[:meeting_request][:accepted] = true
    if params[:meeting_request][:date]
      updated = true
    end
    respond_to do |format|
      if @meeting_request.update_attributes(params[:meeting_request])
        #format.html { redirect_to(@meeting_request, :notice => 'Your meeting request was received.  You should receive an email from one of the counselors shortly.') }
        Notifier.delay.request_acknowledged(@meeting_request,updated) 
        format.html {redirect_to dashboard_path}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meeting_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_requests/1
  # DELETE /meeting_requests/1.xml
  def destroy
    @meeting_request = current_school.meeting_requests.find(params[:id])
    @meeting_request.destroy

    respond_to do |format|
      format.html { redirect_to(meeting_requests_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def choose_layout    
    if [ 'welcome' ].include? action_name
      'logged_out'
    else
      'standard'
    end
  end
end
