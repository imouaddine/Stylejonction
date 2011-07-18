class PublicPortfoliosController < ApplicationController

  respond_to :html, :json

  def show
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.published?
      respond_with @portfolio
    else
      redirect_to "/"
    end
  end

end
