require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @image = Factory.create(:image)
    @image.editable = true
    @image.display_format.scalable = true
    @image.display_format.save
    @image.upload "test/fixtures/images/1.jpg"
    @image.save
    @user = Factory(:user)
    @request.host = "#{@user.username}.stylejonction.com"
   
    
    sign_in @user
  end


  test "should crop image" do
  
     
    post :crop, :id => @image.id, :x => 10.3, :y => 11.44, :format => 'json'

    assert_response :success

    @image.reload

    assert_equal @image.display_format.crop_x, 10.3
    assert_equal @image.display_format.crop_y, 11.44
    assert_equal @image.scale_to_fit?, false
  end

  test "should scale image" do
    
     post :update, :id => @image.id, :image => {scale_to_fit: true}, :format => 'json'
     assert_response :success

     @image.reload
   
     assert_equal @image.scale_to_fit?, true
  end




end
