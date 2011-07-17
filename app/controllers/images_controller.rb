class ImagesController < ApplicationController
  before_filter :authenticate_user!
  
  layout 'modal'
  
  def edit 
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  def update
     @image = Image.find(params[:id])
     respond_to do |format|
       if @image.update_attributes(params[:image])
         format.js 
         format.json {render :json => @image}
       else
         format.js {render :template => 'portfolios/upload_cover_error'}
         format.json {render :json => @image.errors }
       end
     end
  end
   
   
  def crop
     @image = Image.find(params[:id])
     respond_to do |format|
       if @image.crop(params[:x], params[:y])
         format.json { head :ok }
       else 
         format.json { @image.thumb_format.errors.inspect }
       end
     end
  end
  
  def scale_to_fit
     @image = Image.find(params[:id])
     respond_to do |format|
        if @image.scale_to_fit
          format.json { head :ok }
        else 
          format.json { @image.errors.inspect }
        end
      end
  end
  
end