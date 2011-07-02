module ProjectsHelper
  def url_for_action(p)
    p.new_record? ? portfolio_projects_path : portfolio_project_path(p)
  end
end
