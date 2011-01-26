class StudentsController < ApplicationController
  layout 'new_application'
  before_filter :title
  before_filter :retrieve_non_member_groups, :only => [:edit, :update]
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
    if params[:last_name]
      @students = current_school.students.where('last_name ilike ? or first_name ilike ?', "%" + params[:last_name] + "%", "%" + params[:last_name] + "%").order(:last_name)
    else
      @students = current_school.students.order(:last_name) if !params[:last_name]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = current_school.students.find(params[:id])
    @note = Note.new
    @note.created_at = DateTime.now
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
    title
  end
  
  def retrieve_non_member_groups
    @student = current_school.students.find(params[:id])
    @other_groups = current_school.groups - @student.groups
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    @student.school = current_school
    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
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
    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(edit_student_path(@student), :notice => 'Student was successfully updated.') }
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
end
