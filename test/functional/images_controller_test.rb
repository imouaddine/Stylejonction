require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @image = Factory.create(:image)
    @user = Factory(:user)
    @request.host = "#{@user.username}.stylejonction.com"
  end


  test "should crop image" do
    create_image

    post :crop, :id => @image.id, :x => 10.3, :y => 11.44, :format => 'json'

    assert_response :success

    @image.reload

    assert_equal @image.thumb_format.crop_x, 10.3
    assert_equal @image.thumb_format.crop_y, 11.44
    assert_equal @image.thumb_format.scale_to_fit?, false
  end

  test "should scale image" do

     create_image

     post :scale_to_fit, :id => @image.id, :scale_to_fit => true, :format => 'json'
     assert_response :success

     @image.reload
     assert_equal @image.thumb_format.scale_to_fit?, true
  end


  def create_image
    sign_in @user
    @image.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/1.jpg")))
    assert_equal true, @image.save, @image.errors.inspect
  end

end
