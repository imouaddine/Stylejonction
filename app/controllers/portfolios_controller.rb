class PortfoliosController < ApplicationController
  respond_to :html, :json

  before_filter :get_portfolio
  before_filter :authenticate_user!, :except => [:show]

  skip_before_filter :verify_authenticity_token


  def show
    @projects = @portfolio.projects
    respond_with @portfolio
    
  end

  def publish
    @portfolio.publish!
    respond_to do |format|
      format.html { redirect_to :back, notice: "Portfolio published" }
      format.json { render json: @portfolio }
    end
  end

  def edit_layout
    @layouts = Portfolio::LAYOUTS
    @backgrounds = PredefinedBackground.all
    @background = @portfolio.background
    @patterns = Pattern.all
    
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
