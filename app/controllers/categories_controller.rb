class CategoriesController < AuthorizedController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.accessible_by(current_ability).all.sort {|x,y| x.name <=> y.name}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = current_school.categories.find(params[:id])
    @notes = @category.notes.accessible_by(current_ability)
    page_notes
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
      format.js
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
    redirect_to category_path(@category), notice: "You cannot edit system categories" if @category.system 
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
    @category = current_school.categories.find(params[:id])
    begin
      start_date = Time.strptime(params[:start_date], "%Y-%m-%d") unless params[:start_date].nil? || params[:start_date].empty? 
    rescue ArgumentError
      flash[:alert] = "The Start Date was invalid"
      redirect_to @category
      return
    end

    begin
      end_date = Time.strptime("#{params[:end_date]} 23:59", "%Y-%m-%d %H:%M") unless params[:end_date].nil? || params[:end_date].empty? 
    rescue ArgumentError
      flash[:alert] = "The End Date was invalid"
      redirect_to @category
      return
    end

    if start_date && end_date
      @notes = @category.notes.accessible_by(current_ability).where('created_at >= ? AND created_at <= ?', start_date, end_date)
      name = "#{@category.name}_#{start_date.strftime("%Y-%m-%d")}_#{end_date.strftime("%Y-%m-%d")}"
    elsif start_date
      @notes = @category.notes.accessible_by(current_ability).where('created_at >= ?', start_date)
      name = "#{@category.name}_from_#{start_date.strftime("%Y-%m-%d")}"
    elsif end_date
      @notes = @category.notes.accessible_by(current_ability).where('created_at <= ?', end_date)
      name = "#{@category.name}_until_#{end_date.strftime("%Y-%m-%d")}"
    else
      @notes = @category.notes.accessible_by(current_ability)
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

  private
  def uncategorized_cat
    current_school.categories.find_by_name 'Uncategorized'
  end
end
