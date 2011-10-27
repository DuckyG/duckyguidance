class UsersController < ApplicationController

  before_filter :authorize!
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
    @counselor = User.new
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
    @counselor = User.new(params[:counselor])
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

     @counselor = current_user
     @title = "My Settings"
  end

  def my_account_update

    @user = current_user
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    @user.school = current_school
    respond_to do |format|
      if @user.update_attributes(params[:user])
        sign_in(@user, :bypass => true)
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

  private

  def authorize!
    authenticate_user_against_school!
    case action_name
    when "my_account", "my_account_update"
      return
    when "index", "show"
      unless current_user.counselor?
        raise ::Guidance::PermissionDenied
      end
    else
      unless current_user.director?
        raise ::Guidance::PermissionDenied
      end
    end
  end
end
