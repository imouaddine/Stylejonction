class GalleriesController < ApplicationController
 

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @gallery = Gallery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.json
  def new
    @gallery = Gallery.new
    
    respond_to do |format|
      format.html{ redirect_to edit_portfolio_project_path(params[:project_id])+"?new_gallery=1" }
      format.json { render json: @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
    @gallery = Gallery.find(params[:id])
    redirect_to get_redirect_path
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = Gallery.new(params[:gallery])
   
    respond_to do |format|
      if @gallery.save
        format.html { redirect_to get_redirect_path, notice: 'Gallery was successfully created.' }
        format.json { render json: @gallery, status: :created, location: @gallery }
      else
        flash[:error] = "Gallery cannot be created. Please correct form errors"
        format.html { redirect_to edit_portfolio_project_path(@gallery.project_id)+"?new_gallery=1" }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.json
  def update
    @gallery = Gallery.find(params[:id])
    
    #update order of elements
    if params[:gallery_weight]
      weights = params[:gallery_weight].split("&").map{|s| s.gsub("element[]=", "") }
      
      @gallery.elements.each do |element|
        element.weight = weights.index(element.id.to_s)
        element.save
      end
    end
   
   respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        format.html { redirect_to get_redirect_path, notice: 'Gallery was successfully updated.' }
        format.json { head :ok }
      else
        flash[:error] = "Gallery cannot be created. Please correct form errors"
        format.html { redirect_to get_redirect_path }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy

    respond_to do |format|
      flash[:notice] = "Gallery <em>#{@gallery.title}</em> has been deleted.".html_safe
      format.html{ redirect_to edit_portfolio_project_path(@gallery.project_id)+"?new_gallery=1" }
      format.json { head :ok }
    end
  end
  
  private
    
    def get_redirect_path
      edit_portfolio_project_path(@gallery.project)+"?gallery_id=#{@gallery.id}"
    end
  
end
