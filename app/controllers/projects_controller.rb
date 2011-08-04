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
    @project = get_project(params[:id])
    respond_to do |format|
      format.json {render :text => @project.to_json(:include => :cover) }
      format.html
    end
  end

  def new
    next_number = @portfolio.projects.count + 1
    @project = @portfolio.projects.new(:title => "Project #{next_number}")
    @project.cover = Image.new(:dir => 'project')
    @project.setup_cover
    @cover = @project.cover
    @text_block = @project.text_blocks.new
    @gallery = @project.galleries.new
    @document_block = @project.document_blocks.new
    respond_with(@project)
  end

  def create
    next_number = @portfolio.projects.count + 1
    cover = params[:project].delete(:cover)

    @project = @portfolio.projects.new(params[:project])
    cover.present? ? create_cover : find_and_assign_cover(params[:project][:cover_name])
    flash[:notice] = "Project was successfully created" if @project.save!

    redirect_to edit_portfolio_project_path(@project)
  end

  def edit
    @tab = params[:tab] ? params[:tab] : 0
    @content_tab = params[:content_tab] ? params[:content_tab] : 0
   
    @project = get_project(params[:id])
    @cover = @project.cover
    @text_block = @project.text_blocks.new
    
    if params[:gallery_id]
      @gallery = @project.galleries.find(params[:gallery_id])
      @tab = @content_tab = 1
    else
      @gallery = @project.galleries.new
    end
    
    if params[:new_gallery]
      @tab =  @content_tab = 1
    end
    @document_block = @project.document_blocks.new
    respond_with(@project)
  end

  def update
    @project = get_project(params[:id])
    @tab = params[:tab] ? params[:tab] : 0
    @content_tab = params[:content_tab] ? params[:content_tab] : 0
    weights = params[:weight].split("&").map{|s| s.gsub("element[]=", "") }
    @project.elements.each do |element|
      element.weight = weights.index(element.id.to_s)
      element.save
    end
    check_defaultness
    #update_cover
    flash[:notice] = "Project was successfully updated" if @project.update_attributes(params[:project])
    redirect_to edit_portfolio_project_path(@project)+"?tab=#{@tab}&content_tab=#{@content_tab}"
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

  def get_project(project_id)
    @portfolio.projects.find(project_id)
  end

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

  def find_and_assign_cover(cover_name)
    cover = Image.where(:image => cover_name).order("created_at").last rescue nil
    if cover
      @project.cover = cover
    end
  end
end
