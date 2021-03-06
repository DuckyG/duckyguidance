class TagsController < AuthorizedController
  # GET /tags
  # GET /tags.xml
  def index
    @tags = current_school.tags.accessible_by(current_ability)
    @title = 'Tags'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = current_school.tags.find(params[:id])
    @title = 'Tags: ' + @tag.name
    @notes = @tag.notes.accessible_by(current_ability).page(params[:note_page])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
      format.js
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = current_school.tags.new
    @title = 'New Tag'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = current_school.tags.find(params[:id])
    @title = 'Edit Tag'
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to(@tag) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = current_school.tags.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(@tag, :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = current_school.tags.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end
end
