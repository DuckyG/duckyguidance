class NotesController < AuthorizedController
  # GET /notes
  # GET /notes.xml
  def index
    if params[:student_id]
      @student = current_school.students.accessible_by(current_ability).find(params[:student_id])
      @notes =  @student.notes if @student
    elsif params[:group_id]
      @group = current_school.groups.accessible_by(current_ability).find(params[:group_id])
      @notes =  @group.notes if @group
    else
      @notes = current_school.notes.accessible_by(current_ability)
    end
    page_notes
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
      format.json {render :json => @notes}
      format.js
    end
  end

  def unassigned
    @notes = current_school.notes.accessible_by(current_ability).unassigned.page(params[:page])
    page_notes
    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end
  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = current_school.notes.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = current_school.notes.new
    @note.students<< current_school.students.find(params[:student_id])
    @note.counselor = current_user
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = current_school.notes.find(params[:id])
    @note.tags_string = @note.get_tag_string
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = current_school.notes.build(params[:note])
    @student_id_string = params[:note][:student_ids]
    @note.counselor = current_user
    respond_to do |format|
      if @note.save
        if(@note.notify_students_counselor == '1')
          Notifier.another_counselor_post(@note).deliver
        end
        @target = @note.students.first
        unless @note.groups.first.nil?
          @target = @note.groups.first
        end
        unless @note.smart_groups.first.nil?
          @target = @note.smart_groups.first
        end
        format.html { redirect_to(@target) }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = current_school.notes.find(params[:id])
    @student = @note.students.first

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = current_school.notes.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to(dashboard_path, notice: "Note has been deleted") }
      format.xml  { head :ok }
    end
  end

  def search
    auth_ids =  params[:author_ids].map(&:to_i) if params[:author_ids]
    category_ids = params[:category_ids].map(&:to_i) if params[:category_ids]
    start_date = params[:start_date] unless params[:start_date].nil? ||  params[:start_date].empty?
    end_date = params[:end_date] unless params[:end_date].nil? || params[:end_date].empty?
    year_of_grad = params[:year_of_graduation] unless params[:year_of_graduation].nil? ||  params[:year_of_graduation].empty?
    shop_str= "%#{params[:shop]}%" unless params[:shop].nil? || params[:shop].empty?
    student_name= "%#{params[:student_name]}%" unless params[:student_name].nil? || params[:student_name].empty?
    tags = params[:tags].split(' ') unless params[:tags].nil? || params[:tags].empty?
 
    if year_of_grad || shop_str || student_name
      ids = current_school.students.where do
        conditions = {}
        conditions[year_of_graduation] = year_of_grad if year_of_grad
        conditions[shop.matches] = shop_str if shop_str
        conditions[full_name.matches] = student_name if student_name
        conditions
      end.joins(:notes).select("notes.id")
      @notes = current_school.notes.where(:id => ids)
    else
        @notes = current_school.notes
    end

    if tags
      @tag_note_ids = current_school.tags.where do
        {name.matches_any => tags}
      end.joins(:notes).select("notes.id")
      @notes = @notes.where(:id => @tag_note_ids)
    end

    @notes = @notes.where do
      conditions = {}
      conditions[notes.counselor_id] = auth_ids if auth_ids
      conditions[notes.category_id] = category_ids if category_ids
      conditions[notes.created_at.gteq] = start_date if start_date
      conditions[notes.created_at.lteq] = end_date if end_date
      conditions
    end

    @notes = @notes.page(params[:page])
  end
end
