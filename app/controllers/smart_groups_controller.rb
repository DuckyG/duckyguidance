class SmartGroupsController < ApplicationController
  access_control do
    actions :index, :show, :snapshot do
      allow :counselor, :of => :current_school
      allow :superadmin
    end

    actions :new, :create do
      allow :school_admin, :of => :current_school
      allow :counselor, :of => :current_school
    end

    actions :edit, :update do
      allow :school_admin, :of => :current_school
      allow :counselor, :of => :current_school
    end

    action :destroy do
      allow :school_admin,:of => :current_school
    end
  end

  before_filter :retrieve_fields
  # GET /smart_groups
  # GET /smart_groups.xml
  def index
    if params[:field] && params[:value]
      @smart_group = current_school.smart_groups.find_by_field_name_and_field_value(params[:field], params[:value])
      if @smart_group
        redirect_to @smart_group 
        return
      end
      flash[:notice] =  "A smart group for this filter does not exist yet. Complete this form to create one."
      value = params[:value]

      if params[:field] == "counselor_id"
        begin
          counselor = current_school.counselors.find params[:value]
          value = counselor.formal_name
        rescue ActiveRecord::RecordNotFound
        end
      end
      redirect_to(new_smart_group_path(:field => params[:field], :value => value) )
      return
    end
    @smart_groups = current_school.smart_groups.page(params[:page])
    @title = 'Smart Groups'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @smart_groups }
      format.js
    end
  end

  # GET /smart_groups/1
  # GET /smart_groups/1.xml
  def show
    @smart_group = current_school.smart_groups.find(params[:id])
    @students = @smart_group.students.page(params[:student_page]).per(5)
    @note = Note.new
    @notes = @smart_group.notes.page(params[:note_page])
    @smart_group_id_string = @smart_group.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @smart_group }
      format.js
    end
  end

  def snapshot
    @smart_group = current_school.smart_groups.find(params[:id])
    group = Group.new
    group.school = current_school
    group.name = params[:name]
    group.description = params[:description]
    group.students = @smart_group.students

    if group.save
      redirect_to group
    end
  end

  # GET /smart_groups/new
  # GET /smart_groups/new.xml
  def new
    @smart_group = current_school.smart_groups.build
    if params[:field] && params[:value]
      @smart_group.field_name = params[:field]
      @smart_group.field_value = params[:value]
    end
    @title = 'New Smart Group'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @smart_group }
    end
  end

  # GET /smart_groups/1/edit
  def edit
    @smart_group = current_school.smart_groups.find(params[:id])

  end

  # POST /smart_groups
  # POST /smart_groups.xml
  def create
    @smart_group = SmartGroup.new(params[:smart_group])
    @smart_group.school = current_school
    respond_to do |format|
      if @smart_group.save
        format.html { redirect_to(@smart_group, :notice => 'SmartGroup was successfully created.') }
        format.xml  { render :xml => @smart_group, :status => :created, :location => @smart_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @smart_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /smart_groups/1
  # PUT /smart_groups/1.xml
  def update
    @smart_group = current_school.smart_groups.find(params[:id])
    if params[:smart_group][:student_ids].nil?
      @smart_group.students.clear
    end
    respond_to do |format|
      if @smart_group.update_attributes(params[:smart_group])
        format.html { redirect_to(@smart_group, :notice => 'SmartGroup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @smart_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /smart_groups/1
  # DELETE /smart_groups/1.xml
  def destroy
    @smart_group = current_school.smart_groups.find(params[:id])
    @smart_group.destroy

    respond_to do |format|
      format.html { redirect_to(smart_groups_url) }
      format.xml  { head :ok }
    end
  end

  private 
  
  def retrieve_fields
    @fields = Student.smart_fields.map{|k,v| [k,v]}
  end
end
