require 'test_helper'
 
class ProjectTest < ActiveSupport::TestCase
  
  test "Should not save project without title" do
    user = Factory(:user)
    portfolio = user.portfolio
    project = portfolio.projects.new
    assert !project.save, 'project title should be mandatory'
  end

  test "saves valid project" do
    user = Factory(:user)
    portfolio = user.portfolio
    project = portfolio.projects.new
    project.title = 'Title'
    assert project.save
  end
  
  
end
