class ImagesController < ApplicationController
  before_filter :authenticate_user!

  layout 'modal'
  # GET /text_blocks/1
  # GET /text_blocks/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end
  
  def edit
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def upload
     @selector  = params[:selector]
     if params[:id].present?
      @image = Image.find(params[:id])
     else
      cover = params[:image].delete :image
      @image = Image.new(params[:image])
      @image.image = cover
      @image.save
     end
     respond_to do |format|
       if @image.update_attributes(params[:image])
         format.html { render :layout => false }
         format.json {render :json => @image}
       else
         format.html
         format.json {render :json => @image.errors }
       end
     end
  end
  
  def crop
     @image = Image.find(params[:id])
     respond_to do |format|
       if @image.crop(params[:x], params[:y])
         format.json { render :json => @image  }
       else
         format.json { @image.errors.inspect }
       end
     end
  end

  def update
    @image = Image.find(params[:id])
    respond_to do |format|
        if @image.update_attributes(params[:image])
          format.json { render :json => @image  }
        else
          format.json { @image.errors.inspect }
        end
      end
  end
  
  
  def remove_upload
    @image = Image.find(params[:id])
    
    respond_to do |format|
      if @image.delete_image!
        format.js
        format.json { render json: @background }
      end
    end
    
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    
    respond_to do |format|
      format.json { head :ok }
    end
  end
 

end
