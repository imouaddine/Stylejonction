class PredefinedBackgroundsController < ApplicationController
  
  def show
     @predefined_background = PredefinedBackground.find(params[:id])
     respond_to do |format|
       format.json { render json: @predefined_background }
     end
  end
  
  
end