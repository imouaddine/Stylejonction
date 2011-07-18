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
    @project = @portfolio.projects.create(:title => "Project #{next_number}")
    redirect_to edit_portfolio_project_path(@project)
  end

  def create
    next_number = @portfolio.projects.count + 1
    @project = @portfolio.projects.create(:title => "Project #{next_number}")
    redirect_to edit_portfolio_project_path(@project)
  end

  def edit
    @project = @portfolio.projects.find(params[:id])
  end

  def update
    @project = @portfolio.projects.find(params[:id])
    flash[:notice] = "Project was successfully updated" if @project.update_attributes(params[:project])
    respond_with(@project)
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

    respond_to do |format|
      format.html { redirect_to portfolio_path }
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
end
