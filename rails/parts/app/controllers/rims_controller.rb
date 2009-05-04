class RimsController < ApplicationController
  # GET /rims
  # GET /rims.xml
  def index
    @rims = Rim.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rims }
    end
  end

  # GET /rims/1
  # GET /rims/1.xml
  def show
    @rim = Rim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rim }
    end
  end

  # GET /rims/new
  # GET /rims/new.xml
  def new
    @rim = Rim.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rim }
    end
  end

  # GET /rims/1/edit
  def edit
    @rim = Rim.find(params[:id])
  end

  # POST /rims
  # POST /rims.xml
  def create
    @rim = Rim.new(params[:rim])

    respond_to do |format|
      if @rim.save
        flash[:notice] = 'Rim was successfully created.'
        format.html { redirect_to(@rim) }
        format.xml  { render :xml => @rim, :status => :created, :location => @rim }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rims/1
  # PUT /rims/1.xml
  def update
    @rim = Rim.find(params[:id])

    respond_to do |format|
      if @rim.update_attributes(params[:rim])
        flash[:notice] = 'Rim was successfully updated.'
        format.html { redirect_to(@rim) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rims/1
  # DELETE /rims/1.xml
  def destroy
    @rim = Rim.find(params[:id])
    @rim.destroy

    respond_to do |format|
      format.html { redirect_to(rims_url) }
      format.xml  { head :ok }
    end
  end
end
