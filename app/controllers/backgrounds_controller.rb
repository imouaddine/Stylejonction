class BackgroundsController < ApplicationController
  before_filter :get_portfolio
  before_filter :authenticate_user!, :except => [:show]
  layout 'modal'
  
  respond_to :html, :json
  
  def show
    @background = @portfolio.background
    respond_with do |format|
      format.json { render json: @background }
    end
  end
  
  
  def edit
    @background = @portfolio.background
    redirect_to edit_layout_portfolio_path unless @portfolio.has_custom_background?
  end
 
  def update
    
    @background = @portfolio.background
    
    respond_with do |format|
      if @background.update_attributes(params[:background])
        format.json { render json: @background }
      else 
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def upload
      @background = CustomBackground.new
      respond_with do |format|
        if @background.update_attributes(params[:background])
            @portfolio.save
            format.js
        else
            render :template => 'shared/upload_error'
        end
      end
  end
end
