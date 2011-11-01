class StudentsController < AuthorizedController
  before_filter :title
  before_filter :retrieve_note
  def title
    @section = 'Students'
  end

  # GET /students
  # GET /students.xml
  def index
    @students = current_school.students.accessible_by(current_ability).current
    @students = @note.students if @note
    search_and_page_students
    @show_counselor = true
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @students }
      format.js
    end
  end

  def inactive
    @students = current_school.students.accessible_by(current_ability).inactive
    search_and_page_students
    @show_counselor = true
    respond_to do |format|
      format.html { render :index }
      format.xml  { render :xml => @students }
      format.js   { render :index }
    end

  end

  def all
    @students = current_school.students.accessible_by(current_ability)
    search_and_page_students
    @show_counselor = true
    respond_to do |format|
      format.html { render :index }
      format.xml  { render :xml => @students }
      format.js   { render :index }
    end

  end


  def search
    search_term = "#{params[:q]}%"
    @students = current_school.students.accessible_by(current_ability).search_by_first_or_last_name(search_term)
    render :json => @students.map{ |student| {id: student.id, name: student.full_name}}
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = current_school.students.find(params[:id])
    @note = Note.new
    @note.created_at = DateTime.now
    @notes = @student.notes.accessible_by(current_ability)
    page_notes
    @student_id_string = @student.id
    title
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
      format.js
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = current_school.students.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = current_school.students.find(params[:id])
    title
    @student.distribute_phone_number
  end
  
  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])
    @student.school = current_school
    respond_to do |format|
      if @student.save
        format.html { redirect_to(@student) }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = current_school.students.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = current_school.students.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end

  private

  def search_and_page_students
    search_term = "#{params[:search]}%" unless params[:search].nil? or params[:search].empty?

    @students = @students.search_by_first_or_last_name(search_term) if search_term
    @students = @students.page(params[:page])
  end

  def retrieve_note
    @note = current_school.notes.find(params[:note_id]) if params[:note_id]
  end

end
