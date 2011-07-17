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

  test "is public by default" do
    project = Project.new
    assert  project.public?
  end

  test "is not default when created" do
    project = Project.new
    assert ! project.default?
  end
  
  test "is image set when created" do
    project = Project.new(:title => 'New project')
    
    assert project.cover.thumb_format, "thumb should be created on initialization"
    assert project.cover.original_format, "original should be created on initialization"
    
    assert_equal true, project.cover.save
    assert_equal true, project.save, project.errors.inspect
    
    project.reload
     
   
   
    assert_equal 165, project.cover.thumb_format.width
    assert_equal 165, project.cover.thumb_format.height
    
  
    
  end 
  
  


  test "can change projects visibility" do
    project = Factory.create(:project)

    project.public = true
    project.save!

    assert project.public?
  end

  test "can set project to default" do
    project = Factory.create(:project)

    project.default = true
    project.save!

    assert project.default?
  end

  test "if user has 2 projects setting one to default changes the other one" do
    user = Factory.create(:user)

    p1 = Project.create(:title => "one", :default => true)
    p2 = Project.create(:title => "two")

    user.portfolio.projects << p1
    user.portfolio.projects << p2

    p2.set_to_default
    p1.reload

    assert_equal p2, user.default_project
    assert_equal false, p1.default?
  end

  test "can invite someone to the project" do
    user = Factory.create(:user)
    p1 = Project.create(:title => "one")
    user.portfolio.projects << p1

    p1.invite("john@mail.ma")

    assert_equal 1, Invitation.count
    assert ! Invitation.first.used?, "Invitation shouldn't be used"
  end
end
