class NotesController < ApplicationController
  access_control do
    allow :counselor, :of => :current_school
  end
  layout Proc.new { |controller| controller.request.xhr? ? 'ajax' : 'application' }
  # GET /notes
  # GET /notes.xml
  def index
    @notes = current_school.notes
    @student = current_school.students.find(params[:student_id]) if params[:student_id]
    @notes =  @student.notes if @student
    @group = current_school.groups.find(params[:group_id]) if params[:group_id]
    @notes =  @group.notes if @group
    @notes = @notes.sort {|x,y| y.created_at <=> x.created_at}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
      format.json {render :json => @notes}
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = current_school.notes.find(params[:id])
    @title = 'Note Details'
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = current_school.notes.new
    @note.students<< current_school.students.find(params[:student_id])
    @note.counselor = current_counselor
   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = current_school.notes.find(params[:id])
    @title = 'Edit Note'
    @note.tags_string = @note.get_tag_string
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    @note.counselor = current_counselor
    @note.school = current_school
    respond_to do |format|
      if @note.save!
        if(@note.notify_students_counselor == '1')
          Notifier.another_counselor_post(@note).deliver
        end
        format.html { redirect_to(@note.students.first, :notice => 'Note was successfully created.') }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = current_school.notes.find(params[:id])
    @student = @note.students.first

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(@student, :notice => 'Note was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = current_school.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(notes_url) }
      format.xml  { head :ok }
    end
  end
end
