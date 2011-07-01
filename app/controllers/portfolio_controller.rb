class PortfolioController < ApplicationController
  before_filter :get_portfolio, :except => [:new, :create]
  before_filter :authenticate_user!, :except => [:show]

  def show
    if params[:id].present?
      @portfolio = @user.portfolio
    end

    respond_to do |format|
      format.html 
      format.json { render json: @portfolio }
    end
  end

  def edit_layout; end
  def edit_font; end

  def update
    respond_to do |format|
      if @portfolio.update_attributes(params[:portfolio])
        format.html { redirect_to portfolio_path @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

end
