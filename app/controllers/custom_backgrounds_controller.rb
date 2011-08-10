class CustomBackgroundsController < ApplicationController
  
  layout 'modal'
  
  respond_to :html, :json, :js
  
  before_filter :authenticate_user!
  
  def edit
     @background = CustomBackground.find(params[:id])
  end
  
  def update
    @background = CustomBackground.find(params[:id])
    respond_with do |format|
      if @background.update_attributes(params[:custom_background])
        format.json { render json: @background }
      else
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def upload 
     @background = CustomBackground.find(params[:id])
     respond_with do |format|
       if @background.image.update_attribute(:image,  params[:custom_background][:image][:image])
         format.js
       end
     end
  end
  
  def remove_upload
      @background = CustomBackground.find(params[:id])
      respond_with do |format|
        if @background.delete_image! 
          format.js { render template: '/custom_backgrounds/upload' }
          format.json { render json: @background }
        end
     end
  end
  
  def create
    @background = CustomBackground.new(params[:background])
    @background.user = current_user
    respond_with do |format|
      if @background.save
        format.js
        format.json { render json: @background, status: :created, location: @background }
      else
        format.js { render :template => 'shared/upload_error' }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end
end