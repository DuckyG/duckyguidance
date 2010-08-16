class MeetingRequestsController < ApplicationController
  # GET /meeting_requests
  # GET /meeting_requests.xml
  def index
    @meeting_requests = MeetingRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meeting_requests }
    end
  end

  # GET /meeting_requests/1
  # GET /meeting_requests/1.xml
  def show
    @meeting_request = MeetingRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meeting_request }
    end
  end

  # GET /meeting_requests/new
  # GET /meeting_requests/new.xml
  def new
    @meeting_request = MeetingRequest.new
    @title = 'Request a Meeting'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting_request }
    end
  end

  # GET /meeting_requests/1/edit
  def edit
    @meeting_request = MeetingRequest.find(params[:id])
  end

  # POST /meeting_requests
  # POST /meeting_requests.xml
  def create
    @meeting_request = MeetingRequest.new(params[:meeting_request])
    @meeting_request.desired_date = @meeting_request.date + ' ' + @meeting_request.time
    respond_to do |format|
      if @meeting_request.save
        Notifier.request_submitted(@meeting_request).deliver
        Notifier.request_received(@meeting_request).deliver
        format.html { redirect_to(thankyou_path, :notice => 'Your meeting request was received.  You should receive an email from one of the counselors shortly.') }
        format.xml  { render :xml => @meeting_request, :status => :created, :location => @meeting_request }
      else
        format.html { render :url=> request_path,:action => "new" }
        format.xml  { render :xml => @meeting_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meeting_requests/1
  # PUT /meeting_requests/1.xml
  def update
    @meeting_request = MeetingRequest.find(params[:id])
    @meeting_request.accepted = params[:accepted]
    respond_to do |format|
      if @meeting_request.update_attributes(params[:meeting_request])
        #format.html { redirect_to(@meeting_request, :notice => 'Your meeting request was received.  You should receive an email from one of the counselors shortly.') }
        Notifier.request_acknowledged(@meeting_request).deliver
        format.js {@current_request = @meeting_request}
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
    @meeting_request = MeetingRequest.find(params[:id])
    @meeting_request.destroy

    respond_to do |format|
      format.html { redirect_to(meeting_requests_url) }
      format.xml  { head :ok }
    end
  end
end
