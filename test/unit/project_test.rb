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

  test "project upload" do
    user = Factory(:user)
    4.times do |i|
      project = user.portfolio.projects.create(:title => "Project #{i}")
      project.cover.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/#{i}.jpg")))
      project.save!
      assert project.cover.image.url
    end
  end

  test "is image set when created" do
    project = Project.create(:title => 'New project')
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


  test "copy gets created along with the project, one is unpublished " do
    Project.destroy_all
    p1 = Project.create(:title => "one")

    assert_equal Project.count, 2
    assert_equal p1.project_copy.published?, false
    assert_equal p1.published?, true

    assert_equal Project.first.project_copy, Project.last
  end

  test "project gets a default cover before saving " do
    # Just to be sure:
    Image.destroy_all
    Project.destroy_all

    p = Project.new(:title => "Give me a cover!!")
    assert_equal true, p.cover.nil?
    p.save
    assert_equal false, p.cover.nil?
    assert_equal 1, Image.count, "Same image for each copy"
    assert_equal 2, Project.count
    assert_equal Project.first.cover, Project.last.cover, "Should be identical"
  end
end
