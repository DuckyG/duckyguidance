class GroupsController < AuthorizedController
  #before_filter :split_id_string, :only => [:create, :update]
  # GET /groups
  # GET /groups.xml
  def index
    @groups = Group.accessible_by(current_ability).all
    @smart_groups = current_school.smart_groups.accessible_by(current_ability)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = current_school.groups.find(params[:id])
    @students = @group.students.page(params[:student_page]).per(5)
    @note = Note.new
    @notes = @group.notes.accessible_by(current_ability).page(params[:note_page])
    @hide_note_subject = true
    @group_id_string = @group.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
      format.js
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  def search
    search_term = "%#{params[:q]}%"
    @groups = current_school.accessible_by(current_ability).groups.where{ name.matches search_term}
    render :json => @groups.map{ |group| {id: group.id, name: group.name}}
  end

  # GET /groups/1/edit
  def edit
    @group = current_school.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
    @group.school = current_school
    respond_to do |format|
      if @group.save
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = current_school.groups.find(params[:id])
    if params[:group][:student_ids].nil?
      @group.students.clear
    end
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = current_school.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end

  private
  
  def split_id_string
    params[:group][:student_ids] = params[:group][:student_ids].split(',')
    params[:group][:student_ids].delete_if { |key,value| value.to_i ==0 }
  end

end
