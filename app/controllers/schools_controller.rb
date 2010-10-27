class SchoolsController < ApplicationController
  access_control do
    allow :superadmin
  end
  def index
    
  end
  
  def show
    @school = School.find(params[:id])
  end
  
  def new
    @title = "New School"
    @school = School.new
  end
  
  def edit
    @school = School.find(params[:id])
  end
  
  def create
    @school = School.new(params[:school])
    uncat_cat = Category.new

    
    respond_to do |format|
      if @school.save!
        @new_cat = @school.categories.create :name => 'Uncategorized'
        @new_cat.save
        format.html { redirect_to(@school, :notice => 'Student was successfully created.') }
        format.xml  { render :xml => @school, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end
end