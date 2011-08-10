class PhotosController < ApplicationController
  layout "modal"
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_gallery
  before_filter :find_or_build_photo
  


  # GET /photos/1
  # GET /photos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    
  end

  # POST /photos
  # POST /photos.json
  def create
    update_photo
  end
  
  def upload 
    @photo.setup_image()
     respond_to do |format|
       if @photo.image.update_attribute(:image,  params[:image][:image])
         format.js
       end
     end
  end
  
  
  
  # PUT /photos/1
  # PUT /photos/1.json
  def update
    update_photo
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
   
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to edit_gallery_path(@photo.gallery) }
      format.json { head :ok }
    end
  end
  
  protected 
    def update_photo
       @photo.image = Image.find(params[:photo][:image_attributes][:id])
        respond_to do |format|
           if @photo.update_attributes(params[:photo])
             if !@photo.image.scale_to_fit? && params[:crop_x] && params[:crop_y]
                 @photo.image.crop(params[:crop_x], params[:crop_y])
             end
             format.html { redirect_to edit_gallery_path(@photo.gallery) }
             format.json { render json: @photo, status: :created, location: @photo }
           else
             format.html { render action: "new" }
             format.json { render json: @photo.errors, status: :unprocessable_entity }
           end
        end
    end
    def find_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end
    
    def find_or_build_photo
      @photo = params[:id] ? @gallery.photos.find(params[:id]) : @gallery.photos.new
    end
    
end
