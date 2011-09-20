class SmartGroupsController < ApplicationController
  access_control do
    actions :index, :show do
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
  # GET /smart_groups
  # GET /smart_groups.xml
  def index
    if params[:field] && params[:value]
      @smart_group = current_school.smart_groups.find_by_field_name_and_field_value(params[:field], params[:value])
      redirect_to(@smart_group ? @smart_group : new_smart_group_path(:field => params[:field], :value => params[:value]))
      return
    end
    @smart_groups = current_school.smart_groups.page(params[:page])
    @title = 'Smart Groups'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @smart_groups }
    end
  end

  # GET /smart_groups/1
  # GET /smart_groups/1.xml
  def show
    @smart_group = current_school.smart_groups.find(params[:id])
    @students=current_school.students.where("#{@smart_group.field_name} = ?", @smart_group.field_value)
    @note = Note.new
    @title = 'Smart Group: '  + @smart_group.name
    @smart_group_id_string = @smart_group.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @smart_group }
    end
  end

  # GET /smart_groups/new
  # GET /smart_groups/new.xml
  def new
    @smart_group = SmartGroup.new
    @fields = Student.valid_smart_field_names
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
    @title = 'Edit SmartGroup: '  + @smart_group.name

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
        format.html { redirect_to(edit_smart_group_path(@smart_group), :notice => 'SmartGroup was successfully updated.') }
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

end
