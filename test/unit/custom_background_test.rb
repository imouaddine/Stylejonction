require 'test_helper'

class CustomBackgroundTest < ActiveSupport::TestCase
  
  def setup 
     @user = Factory.create(:user)
     @background = Factory(:custom_background, :user => @user)
     
  end
  
  test "user association" do
    @background.save 
    
    @background.reload
    
    assert @background.user
    assert_equal @background.user, @user
  end
  test "upload" do
    
     @background.upload("test/fixtures/images/1.jpg")
     @background.save
     
     @background.reload
     
     assert @background.image
     assert_equal @background.image.dir, "#{@background.user.username}/custom_backgrounds"
     
     assert_equal "/uploads/#{@background.image.dir}/#{@background.image.id}/preview_1.jpg", @background.image.preview_url
  end
  
  test "image format has right dimensions" do
    
     @background.upload("test/fixtures/images/1.jpg")
     @background.save
     @background.reload
     
     assert_equal @background.image.editable?, false
     
     assert_equal @background.image.display_format.width, 0
     assert_equal @background.image.display_format.height, 0
    
     
     assert_equal CustomBackground::PREVIEW_BACKGROUND_FORMAT[:width], @background.image.edit_format.width
     assert_equal CustomBackground::PREVIEW_BACKGROUND_FORMAT[:height], @background.image.edit_format.height
     
     assert_equal CustomBackground::PREVIEW_BACKGROUND_FORMAT[:width], @background.image.preview_format.width
     assert_equal  CustomBackground::PREVIEW_BACKGROUND_FORMAT[:height], @background.image.preview_format.height
   
    
  end
  
end
