require 'test_helper'
 
class ProjectTest < ActiveSupport::TestCase
  
  fixtures :users, :portfolios
  
  # Replace this with your real tests.
  test "Should not save project without title" do
    
    user = users(:user1)
    assert user.valid?
    
    portfolio = user.portfolio
    assert portfolio.valid?
    
    project = portfolio.projects.new
    assert !project.save, 'project title should be mandatory'
    
    project.title = 'Title'
    assert project.save
  end
  
  
end