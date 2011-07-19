class CustomBackgroundsController < ApplicationController
  layout 'modal'
  
  respond_to :html, :json, :js
  
  def edit
     @background = CustomBackground.find(params[:id])
  end
  
  def update
    @background = CustomBackground.find(params[:id])
    respond_with do |format|
      if @background.update_attributes(params[:custom_backgrounds])
        format.json { render json: @background }
      else
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  def upload
    @background = CustomBackground.new
    @background.user = current_user
    respond_with do |format|
      if @background.update_attributes(params[:background])
        format.js
      else
        render :template => 'shared/upload_error'
      end
    end
  end
end