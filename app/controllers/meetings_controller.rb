class MeetingsController < ApplicationController
  layout Proc.new { |controller| controller.request.xhr? ? 'ajax' : 'application' }
  # GET /meetings
  # GET /meetings.xml
  def index
    @meetings = current_school.meetings.order "occured_on DESC"
    @student = current_school.students.find(params[:student_id]) if params[:student_id]
    @meetings =  @student.meetings if @student
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @meetings }
      format.json {render :json => @meetings}
    end
  end

  # GET /meetings/1
  # GET /meetings/1.xml
  def show
    @meeting = current_school.meetings.find(params[:id])
    @title = 'Meeting Details'
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.xml
  def new
    @meeting = current_school.meetings.new
    @meeting.student = current_school.students.find(params[:student_id])
    @meeting.counselor = Counselor.find(current_user.id)
   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = current_school.meetings.find(params[:id])
    @title = 'Edit Meeting'
    @meeting.tags_string = @meeting.get_tag_string
  end

  # POST /meetings
  # POST /meetings.xml
  def create
    @meeting = Meeting.new(params[:meeting])
    @student = @meeting.student
    @meeting.counselor = Counselor.find(current_user.id)
    @meeting.school = current_school
    respond_to do |format|
      if @meeting.save
        format.html { redirect_to(@student, :notice => 'Meeting was successfully created.') }
        format.xml  { render :xml => @meeting, :status => :created, :location => @meeting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.xml
  def update
    @meeting = current_school.meetings.find(params[:id])
    @student = @meeting.student

    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to(@student, :notice => 'Meeting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.xml
  def destroy
    @meeting = current_school.meetings.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to(meetings_url) }
      format.xml  { head :ok }
    end
  end
end
