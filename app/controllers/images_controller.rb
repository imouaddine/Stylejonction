class ImagesController < ApplicationController
  before_filter :authenticate_user!

  layout 'modal'

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
         format.json { @image.thumb_format.errors.inspect }
       end
     end
  end

  def scale_to_fit
     @image = Image.find(params[:id])
     respond_to do |format|
        if @image.scale_to_fit
          format.json { render :json => @image  }
        else
          format.json { @image.errors.inspect }
        end
      end
  end

end
