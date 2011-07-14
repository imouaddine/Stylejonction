class FontsController < ApplicationController
  respond_to :json
  def show
    @font = Font.find(params[:id])
    respond_to do |format|
      format.json { render json: @font }
    end
  end
end
  