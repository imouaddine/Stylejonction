class PublicPortfoliosController < ApplicationController

  respond_to :html, :json

  def show
    @portfolio = Portfolio.find(params[:id])
    respond_with @portfolio
  end

end
