class StudentsController < ApplicationController
  before_filter :title
  before_filter :split_id_string, :only => [:create, :update]
  access_control do
    allow :counselor, :of => :current_school
    allow :superadmin
  end
  def title
    @section = 'Students'
  end

  # GET /students
  # GET /students.xml
  def index
    search_term = "#{params[:search]}%" unless params[:search].nil? or params[:search].empty?
    @students = current_school.students
    @students = @students.search_by_first_or_last_name(search_term) if search_term
    @students = @students.page(params[:page])
    @show_counselor = true
    logger.info @students.to_sql
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
      format.js
    end
  end

  def search
    search_term = "#{params[:q]}%"
    @students = current_school.students.search_by_first_or_last_name(search_term)
    render :json => @students.map{ |student| {id: student.id, name: student.full_name}}
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = current_school.students.find(params[:id])
    @note = Note.new
    @note.created_at = DateTime.now
    @notes = @student.notes.page(params[:page])
    @hide_note_subject = true
    @student_id_string = @student.id
    title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end
  
  def add_group
    @group = current_school.groups.find(params[:group_id])
    @student = current_school.students.find(params[:id])
    @group.students<<@student
    redirect_to edit_student_path(@group)
  end
  
  def remove_group
    @group = current_school.groups.find(params[:group_id])
    @student = current_school.students.find(params[:id])
    @group.students.delete @student
    redirect_to edit_student_path(@group)
  end
  

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = current_school.students.find(params[:id])
    title
    @student.distribute_phone_number
  end
  
  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    @student.school = current_school
    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = current_school.students.find(params[:id])
     if params[:student][:group_ids].nil?
      @group.students.clear
    end

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = current_school.students.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end

  private

  def split_id_string
    params[:student][:group_ids] = params[:student][:group_ids].split(',')
    params[:student][:group_ids].delete_if { |key,value| value.to_i == 0 }
  end

end
