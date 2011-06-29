class PortfolioController < ApplicationController
  before_filter :get_portfolio
  

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def edit 
     
  end

  def update
      respond_to do |format|
        if @portfolio.update_attributes(params[:portfolio])
          format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @portfolio.errors, status: :unprocessable_entity }
        end
      end
  end
  
  
 
  
end
