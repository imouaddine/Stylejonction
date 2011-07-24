module ProjectsHelper
  def url_for_action(p)
    p.new_record? ? portfolio_projects_path : portfolio_project_path(p)
  end

  def path_for_image_upload(project)
    if project.cover.id.present?
      upload_image_path(:format => 'html', :id => project.cover)
    else
      images_upload_path(:format => "html")
    end
  end

  def set_default(i)
    "imad@ecomstrategy.ca" if i == 0
  end
end
