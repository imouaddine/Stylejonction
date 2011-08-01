require 'test_helper'

class PredefinedBackgroundTest < ActiveSupport::TestCase
  def setup 
      @background = Factory(:predefined_background)
   end
   
   test "upload" do
     
      @background.upload("test/fixtures/images/1.jpg")
      @background.save
      @background.reload
      
      assert_equal "/uploads/#{@background.image.dir}/1/preview_1.jpg", @background.image.preview_url
   end

   test "image format has right dimensions" do
      
      @background.upload("test/fixtures/images/1.jpg")
      @background.save
      @background.reload
      
      assert_equal @background.image.display_format.width, 0
      assert_equal @background.image.display_format.height, 0
      assert_equal @background.image.display_format.croppable?, false
      assert_equal @background.image.display_format.scalable?, false

      assert_equal @background.image.edit_format.width, PredefinedBackground::PREVIEW_BACKGROUND_FORMAT[:width]
      assert_equal @background.image.edit_format.height, PredefinedBackground::PREVIEW_BACKGROUND_FORMAT[:height]
      assert_equal @background.image.edit_format.croppable?, false
      assert_equal @background.image.edit_format.scalable?, true


      assert_equal @background.image.preview_format.width, PredefinedBackground::PREVIEW_BACKGROUND_FORMAT[:width]
      assert_equal @background.image.preview_format.height, PredefinedBackground::PREVIEW_BACKGROUND_FORMAT[:height]
      assert_equal @background.image.preview_format.croppable?, false
      assert_equal @background.image.preview_format.scalable?, true

   end
end
