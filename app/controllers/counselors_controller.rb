class CounselorsController < ApplicationController
  access_control do
    actions :index, :show do
      allow :counselor, :of => :current_school
    end

    actions :new, :create do
      allow :school_admin, :of => :current_school
    end

    actions :edit, :update do
      allow :counselor, :of => :current_school, :if => :editing_self?
      allow :school_admin, :of => :current_school
    end

    action :destroy do
      allow :school_admin,:of => :current_school
    end
  end
  # GET /users
  # GET /users.xml
  def index
    @counselors = current_school.counselors.all
    @title = "Counselors"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @counselor = current_school.counselors.find(params[:id])
    @title = 'Counselor: ' + @counselor.first_name + ' ' + @counselor.last_name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @counselor }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @counselor = Counselor.new
    @title = "New Counselor"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @counselor }
    end
  end

  # GET /users/1/edit
  def edit
    @counselor = current_school.counselors.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @counselor = Counselor.new(params[:counselor])
    @counselor.subdomain = current_subdomain
    @counselor.school = current_school
    respond_to do |format|
      if @counselor.save
        format.html { redirect_to(@counselor, :notice => 'Counselor was successfully created.') }
        format.xml  { render :xml => @counselor, :status => :created, :location => @counselor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @counselor = current_school.counselors.find(params[:id])
    @counselor.school = current_school
    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        format.html { redirect_to(@counselor, :notice => 'Counselor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @counselor = current_school.counselors.find(params[:id])
    @counselor.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  def editing_self?
    params[:id].to_i == current_user.id
  end
end