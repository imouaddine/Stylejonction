require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup 
    @user = Factory(:user)
    @portfolio = @user.portfolio
    @project = @portfolio.projects.new(:title => 'TITLE')
  end
  test "Should not save project without title" do
    project = @portfolio.projects.new
    assert !project.save, 'project title should be mandatory'
  end

  test "saves valid project" do
    assert @project.save
  end

  test "is public by default" do
    project = Project.new
    assert  project.public?
  end
  
  test "project upload" do

    @project.upload_cover "test/fixtures/images/1.jpg" 
    @project.save!
    assert @project.cover.preview_url
  end

  test "is image set when created" do
    project = Factory(:project)
    project.title ="New project"
    
    project.save
    project.reload
    
    assert project.cover.display_format, "display should be created on initialization"
    assert project.cover.edit_format, "edit should be created on initialization"
    assert project.cover.preview_format, "original should be created on initialization"
    assert_equal true, project.cover.save
    assert_equal true, project.save, project.errors.inspect
    project.reload
    assert project.cover, project.inspect
    assert_equal 165, project.cover.display_format.width
    assert_equal 165, project.cover.display_format.height
    assert_equal 165, project.cover.preview_format.width
    assert_equal 165, project.cover.preview_format.height
  end

  test "can change projects visibility" do
    project = Factory(:project)
    project.public = true
    project.save!
    project.reload
    assert project.public?
  end

  test "can set project to default" do
    project = Factory.create(:project)

    project.default = true
    project.save!

    assert project.default?
  end



  test "can invite someone to the project" do
   
    project = Factory(:project)
    project.invite("john@mail.ma")

    assert_equal 1, Invitation.count
    assert ! Invitation.first.used?, "Invitation shouldn't be used"
  end

end
