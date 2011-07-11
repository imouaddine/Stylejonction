class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_portfolio
  skip_before_filter :verify_authenticity_token

  def index
    @projects = @portfolio.projects

    respond_to do |format|
      format.html
      format.json { render json: @projects }
    end
  end

  def show
    @project = @portfolio.projects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def new
    @project = @portfolio.projects.create(:title => 'new project')
    #temp find solution later
    redirect_to edit_portfolio_project_path(@project)
  end

  def create
    @project = @portfolio.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to portfolio_project_path(@project), notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @project = @portfolio.projects.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    logger.info @project.inspect
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to portfolio_project_path(@project), notice: 'Project was successfully updated.' }
        format.json { render json: @project}
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def upload_cover
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.js
      else
        render :template => 'portfolios/upload_cover_error'
      end
    end
  end

  def invite
    @project = Project.find(params[:id])

    respond_to do |format|
      if params[:email].present?
        @project.invite(params[:email])
        format.html { redirect_to portfolio_project_path(@project), notice: "#{params[:email]} has been invited to your project" }
        format.json { head :ok }
      else
        format.html { redirect_to portfolio_project_path(@project), notice: "You have to provide an email" }
        format.json { head :ok }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to portfolio_path }
      format.json { head :ok }
    end
  end
end
