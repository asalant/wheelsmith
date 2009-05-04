class WheelsController < ApplicationController
  # GET /wheels
  # GET /wheels.xml
  def index
    @wheels = Wheel.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wheels }
    end
  end

  # GET /wheels/1
  # GET /wheels/1.xml
  def show
    @wheel = Wheel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wheel }
    end
  end

  # GET /wheels/new
  # GET /wheels/new.xml
  def new
    @wheel = Wheel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wheel }
    end
  end

  # GET /wheels/1/edit
  def edit
    @wheel = Wheel.find(params[:id])
  end

  # POST /wheels
  # POST /wheels.xml
  def create
    @wheel = Wheel.new(params[:wheel])

    respond_to do |format|
      if @wheel.save
        flash[:notice] = 'Wheel was successfully created.'
        format.html { redirect_to(@wheel) }
        format.xml  { render :xml => @wheel, :status => :created, :location => @wheel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wheel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wheels/1
  # PUT /wheels/1.xml
  def update
    @wheel = Wheel.find(params[:id])

    respond_to do |format|
      if @wheel.update_attributes(params[:wheel])
        flash[:notice] = 'Wheel was successfully updated.'
        format.html { redirect_to(@wheel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wheel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wheels/1
  # DELETE /wheels/1.xml
  def destroy
    @wheel = Wheel.find(params[:id])
    @wheel.destroy

    respond_to do |format|
      format.html { redirect_to(wheels_url) }
      format.xml  { head :ok }
    end
  end
end
