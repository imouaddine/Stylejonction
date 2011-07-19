class PortfoliosController < ApplicationController
  respond_to :html, :json

  before_filter :get_portfolio
  before_filter :authenticate_user!, :except => [:show]

  skip_before_filter :verify_authenticity_token


  def show
    respond_with @portfolio
  end

  def publish
    @portfolio.publish!
    redirect_to action: "show", notice: "Portfolio was published"
  end

  def edit_layout
    @layouts = Portfolio::LAYOUTS
    @backgrounds = PredefinedBackground.all
    @background = @portfolio.background
  end

  def edit_font
    @background = @portfolio.background
    @webfonts = Font.webfont
    @non_webfonts = Font.non_webfont
  end

  def edit
    redirect_to action: "show"
  end

  def update
    respond_to do |format|
      if @portfolio.update_attributes(params[:portfolio])
        format.html { redirect_to :back, notice: 'Portfolio was successfully updated.' }
        format.json { render json: @portfolio }
      else
        format.html { render action: "show" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end





end
