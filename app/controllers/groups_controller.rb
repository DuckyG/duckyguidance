class GroupsController < ApplicationController
  access_control do
    actions :index, :show do
      allow :counselor, :of => :current_school
      allow :superadmin
    end

    actions :new, :create do
      allow :school_admin, :of => :current_school
      allow :counselor, :of => :current_school
    end

    actions :edit, :update, :add_student, :remove_student do
      allow :school_admin, :of => :current_school
      allow :counselor, :of => :current_school
    end

    action :destroy do
      allow :school_admin,:of => :current_school
    end
  end
  # GET /groups
  # GET /groups.xml
  def index
    @groups = current_school.groups.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = current_school.groups.find(params[:id])
    @students = @group.students.page(params[:student_page]).per(5)
    @note = Note.new
    @group_id_string = @group.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
      format.js
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = current_school.groups.find(params[:id])
    @non_members = current_school.students - @group.students
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
    @group.school = current_school
    respond_to do |format|
      if @group.save
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = current_school.groups.find(params[:id])
    if params[:group][:student_ids].nil?
      @group.students.clear
    end
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = current_school.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
