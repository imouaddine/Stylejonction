module ProjectsHelper
  def url_for_action(p)
    p.new_record? ? portfolio_projects_path : portfolio_project_path(p)
  end

  def set_default(i)
    "imad@ecomstrategy.ca" if i == 0
  end
end
