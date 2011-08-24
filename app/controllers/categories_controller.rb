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
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = current_school.categories.find(params[:id])
    @notes = @category.notes.page(params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @section = "Add a Note Category"
    @category = Category.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = current_school.categories.find(params[:id])
    redirect_to category_path(@category) if @category.system 
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
    @category.school = current_school
    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category) }
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
      if @category.system || @category.update_attributes(params[:category])
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def report
    
    start_date = Time.strptime(params[:start_date], "%m/%d/%Y") unless params[:start_date].nil? || params[:start_date].empty? 
    end_date = Time.strptime("#{params[:end_date]} 23:59", "%m/%d/%Y %H:%M") unless params[:end_date].nil? || params[:end_date].empty? 
    @category = current_school.categories.find(params[:id])
    if start_date && end_date
      @notes = @category.notes.where('created_at >= ? AND created_at <= ?', start_date, end_date)
      name = "#{@category.name}_#{start_date.strftime("%Y-%m-%d")}_#{end_date.strftime("%Y-%m-%d")}"
    elsif start_date
      @notes = @category.notes.where('created_at >= ?', start_date)
      name = "#{@category.name}_from_#{start_date.strftime("%Y-%m-%d")}"
    elsif end_date
      @notes = @category.notes.where('created_at <= ?', end_date)
      name = "#{@category.name}_until_#{end_date.strftime("%Y-%m-%d")}"
    else
      @notes = @category.notes
      name = "#{@category.name}"
    end
    respond_to do |format|
      format.csv {render_csv(name)}
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = current_school.categories.find(params[:id])
    unless @category.system
      uncategorized_cat.notes << @category.notes
      @category.destroy
    end
    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
  
  def uncategorized_cat
    current_school.categories.find_by_name 'Uncategorized'
  end
end
