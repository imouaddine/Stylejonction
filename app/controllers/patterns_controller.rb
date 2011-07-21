class PatternsController < ActionController::Base
  
  def show
      @pattern = Pattern.find(params[:id])
      respond_to do |format|
        format.json { render json: @pattern }
      end
   end
end