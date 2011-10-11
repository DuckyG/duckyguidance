class CounselorsController < ApplicationController
  access_control do
    actions :index, :show do
      allow :counselor, :of => :current_school
      allow :superadmin
    end

    actions :new, :create do
      allow :school_admin, :of => :current_school
    end

    actions :my_account, :my_account_update do
      allow :counselor, :of => :current_school
    end

    actions :edit, :update do
      allow :school_admin, :of => :current_school
    end

    action :sign_in do
      allow all
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
    @title = "Counselor: #{@counselor.full_name}"
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
      @title = "Edit Counselor"
  end
  

  # POST /users
  # POST /users.xml
  def create
    @counselor = Counselor.new(params[:counselor])
    @counselor.subdomain = current_subdomain
    @counselor.school = current_school
    respond_to do |format|
      if @counselor.save
        format.html { redirect_to(@counselor) }
        format.xml  { render :xml => @counselor, :status => :created, :location => @counselor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def my_account

     @counselor = current_counselor
     @title = "My Settings"
  end

  def my_account_update

    @counselor = current_counselor
    params[:counselor].delete(:password) if params[:counselor][:password].blank?
    params[:counselor].delete(:password_confirmation) if params[:counselor][:password_confirmation].blank?

    @counselor.school = current_school
    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        sign_in(@counselor, :bypass => true)
        format.html { redirect_to(my_account_path, :notice => 'Your settings have been updated. Please review the changes made below.') 
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "my_account"}
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    params[:counselor].delete(:password) if params[:counselor][:password].blank?
    params[:counselor].delete(:password_confirmation) if params[:counselor][:password_confirmation].blank?

    @counselor = current_school.counselors.find(params[:id])

    @counselor.school = current_school
    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        format.html { redirect_to(@counselor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit"  }
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

 end
