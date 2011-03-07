class CounselorsController < ApplicationController
  layout "new_application"
  access_control do
    actions :index, :show do
      allow :counselor, :of => :current_school
      allow :superadmin
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
    if params[:id]
      @counselor = current_school.counselors.find(params[:id])
    else
      @counselor = current_counselor
    end
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
    if params[:id]
      @counselor = current_school.counselors.find(params[:id])
      @title = "Edit Counselor"
    else
      @counselor = current_counselor
      @title = "My Settings"
    end
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
    if params[:id]
      @counselor = current_school.counselors.find(params[:id])
      @title = "Edit Counselor"
    else
      @counselor = current_counselor
      @title = "My Settings"
    end
    logger.info request.path
    @counselor.school = current_school
    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        format.html {
          
          if request.path == "/my_account_update"
            session = UserSession.new(:email  => params[:counselor][:email], :password => params[:counselor][:password]) if params[:counselor][:password]
            session.save
            redirect_to(my_account_path, :notice => 'Counselor was successfully updated.') 
          else
            redirect_to(@counselor, :notice => 'Counselor was successfully updated.') 
          end
           }
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
    (params[:id].to_i == current_user.id) || (request.fullpath == "/my_settings_update") || (request.fullpath == "/my_settings")
  end
end