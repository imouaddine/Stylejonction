class PortfoliosController < ApplicationController
  before_filter :get_portfolio
  before_filter :authenticate_user!, :except => [:show]
  
  
   skip_before_filter :verify_authenticity_token
   
   
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @portfolio }
    end
  end

  def publish
    @portfolio.publish!
    redirect_to action: "show", notice: "Portfolio was published"
  end

  def edit_layout
    @layouts = Layout.all 
  end

  def edit_font
    @webfonts = Font.webfont
    @non_webfonts = Font.non_webfont
  end
  
  def edit_background
      @backgrounds = Background.all
  end

  def edit
    redirect_to action: "show"
  end

  def update
    @portfolio.layout = Layout.find(params[:layout][:id]) if params[:layout].present?
    @portfolio.background = Background.find(params[:background][:id]) if params[:background].present?
      
    respond_to do |format|
      if @portfolio.update_attributes(params[:portfolio])
        format.html { redirect_to edit_layout_portfolio_path, notice: 'Portfolio was successfully updated.' }
        format.json { render json: @portfolio }
      else
        format.html { render action: "show" }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

end
