class CounselorsController < ApplicationController
  # GET /counselors
  # GET /counselors.xml
  def index
    @counselors = Counselor.all
    @title = "Counselors"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @counselors }
    end
  end

  # GET /counselors/1
  # GET /counselors/1.xml
  def show
    @counselor = Counselor.find(params[:id])
    @title = 'Counselor: ' + @counselor.first_name + ' ' + @counselor.last_name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @counselor }
    end
  end

  # GET /counselors/new
  # GET /counselors/new.xml
  def new
    @counselor = Counselor.new
    @title = "New Counselor"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @counselor }
    end
  end

  # GET /counselors/1/edit
  def edit
    @counselor = Counselor.find(params[:id])
  end

  # POST /counselors
  # POST /counselors.xml
  def create
    @counselor = Counselor.new(params[:counselor])

    respond_to do |format|
      if @counselor.save
        format.html { redirect_to(@counselor, :notice => 'Counselor was successfully created.') }
        format.xml  { render :xml => @counselor, :status => :created, :location => @counselor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /counselors/1
  # PUT /counselors/1.xml
  def update
    @counselor = Counselor.find(params[:id])

    respond_to do |format|
      if @counselor.update_attributes(params[:counselor])
        format.html { redirect_to(@counselor, :notice => 'Counselor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @counselor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /counselors/1
  # DELETE /counselors/1.xml
  def destroy
    @counselor = Counselor.find(params[:id])
    @counselor.destroy

    respond_to do |format|
      format.html { redirect_to(counselors_url) }
      format.xml  { head :ok }
    end
  end
end
