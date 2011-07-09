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
    @backgrounds = PredefinedBackground.all
    @background = @portfolio.background
  end

  def edit_font
    @webfonts = Font.webfont
    @non_webfonts = Font.non_webfont
  end

  def edit
    redirect_to action: "show"
  end

  # If this method grows any more we should either move this
  # logic to lib/ or to treat fonts/backgrounds/layouts
  # as they should be treated (portfolio's resources)
  # and use separate controllers for them. For now it's
  # OK because it's not that that complicated.
  def update
    @portfolio.layout = Layout.find(params[:layout][:id]) if params[:layout].present?

    if params[:portfolio][:title_color].present?
      @portfolio.title_font.color = params[:portfolio][:title_color]
      @portfolio.title_font.save
    end

    if params[:portfolio][:body_color].present?
      @portfolio.body_font.color = params[:portfolio][:body_color]
      @portfolio.body_font.save
    end

    if params[:background].present?
      @portfolio.background = PredefinedBackground.find(params[:background][:id])
    end

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
