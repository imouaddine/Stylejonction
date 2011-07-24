class ProjectsController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :get_portfolio
  skip_before_filter :verify_authenticity_token

  def index
    @projects = @portfolio.projects
    respond_with(@projects)
  end

  def show
    @project = @portfolio.projects.find(params[:id])
    respond_to do |format|
      format.json {render :text => @project.to_json(:include => :cover) }
      format.html
    end

  end

  def new
    next_number = @portfolio.projects.count + 1
    @project = @portfolio.projects.new(:title => "Project #{next_number}")
    @project.cover = Image.new
    @cover = @project.cover
    respond_with(@project)
  end

  def create
    next_number = @portfolio.projects.count + 1
    cover = params[:project].delete(:cover)
    @project = @portfolio.projects.new(params[:project])
    create_cover

    flash[:notice] = "Project was successfully created" if @project.save!
    @project.make_default if @project.default?

    @project = @project.project_copy if @project.published?
    redirect_to edit_portfolio_project_path(@project)
  end

  def edit
    find_project
    @cover = @project.cover
    respond_with(@project)
  end

  def update
    find_project
    check_defaultness
    update_cover
    flash[:notice] = "Project was successfully updated" if @project.update_attributes(params[:project])
    redirect_to edit_portfolio_project_path(@project)
  end

  def invite
    @project = Project.find(params[:id])
    respond_to do |format|
      if params[:email].present?
        email = params[:email]
        if did_not_send_to?(email)
          @project.invite(params[:email])
        end
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

    if @user.portfolio.projects.count > 0
      #if delete project is default, make the first one the default
      if @project.default?
        @user.portfolio.projects.first.make_default
      end
      @project = @user.portfolio.projects.last
      redirection_path =  edit_portfolio_project_path(@project)
    else
      redirection_path =  edit_layout_portfolio_path(@project)
    end
    respond_to do |format|
      format.html { redirect_to redirection_path, notice: "Project #{@project.title} has been deleted successfully" }
      format.json { head :ok }
    end
  end

  private

  def did_not_send_to?(email)
    invite = Invitation.find_by_email(email) rescue nil
    return true if invite.nil?
    return true if invite.used?
    return false
  end

  def check_defaultness
    set_to_default = params[:project][:default]
    if !@project.default? && set_to_default
      params[:project].delete(:default)
      @project.make_default
    end
  end

  def find_project
    p = Project.find(params[:id])
    @project = p.published? ? p.project_copy : p
  end

  def create_cover
    @project.cover = Image.new
    @project.cover.set_thumb_dimension(165, 165)
    @project.cover.image = cover[:image]
  end

  def update_cover
    cover = params[:project].delete(:cover)
    @project.cover.image = cover[:image]
    @project.cover.save
  end
end
