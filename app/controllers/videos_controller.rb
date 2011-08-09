class VideosController < ApplicationController
  
  layout "modal"
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_gallery
  before_filter :find_or_build_video
    
 
  # GET /videos/1
  # GET /videos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    update_video
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    update_video
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
   
    @video.destroy

    respond_to do |format|
      format.html { redirect_to edit_gallery_path(@video.gallery) }
      format.json { head :ok }
    end
  end
  
  protected 
   def update_video
     respond_to do |format|
       if @video.update_attributes(params[:video])
         format.html { redirect_to edit_gallery_path(@video.gallery), notice: 'Video was successfully created.' }
         format.json { render json: @video, status: :created, location: @video }
       else
         format.html { render action: "new" }
         format.json { render json: @video.errors, status: :unprocessable_entity }
       end
     end
   end
   def find_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end
    def find_or_build_video
      @video = params[:id] ? @gallery.videos.find(params[:id]) : @gallery.videos.new
    end
end
