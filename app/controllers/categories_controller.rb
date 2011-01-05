class CategoriesController < ApplicationController
  access_control do
    actions :index, :show, :report do
      allow :counselor, :of => :current_school
      allow :superadmin
    end

    actions :new, :create do
      allow :school_admin, :of => :current_school
    end

    actions :edit, :update do
      allow :school_admin, :of => :current_school
    end

    action :destroy do
      allow :school_admin,:of => :current_school
    end
  end
  # GET /categories
  # GET /categories.xml
  def index
    @categories = current_school.categories.all.sort {|x,y| x.name <=> y.name}
    @title = 'Categories'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = current_school.categories.find(params[:id])
    @title = 'Category: '  + @category.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new
    @title = 'New Category'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = current_school.categories.find(params[:id])
    @title = 'Edit Category: '  + @category.name
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
    @category.school = current_school
    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = current_school.categories.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def report
    
    @start_date = Date.strptime(params[:start_date], "%Y-%m-%d")
    @end_date = Date.strptime(params[:end_date], "%Y-%m-%d")
    @category = current_school.categories.find(params[:id])
    @notes = @category.notes.where('created_at >= ? AND created_at <= ?', @start_date, @end_date)
    respond_to do |format|
      format.csv {render_csv("#{@category.name}-#{@start_date.strftime("%Y%m%d")}-#{@end_date.strftime("%Y%m%d")}")}
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = current_school.categories.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
