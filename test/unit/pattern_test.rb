require 'test_helper'

class PatternTest < ActiveSupport::TestCase
  def setup 
    @pattern = Pattern.create 
  end
  test "upload" do
     
     @pattern.upload("test/fixtures/images/1.jpg")
     
     assert_equal @pattern.image.dir, "patterns"
     
     @pattern.save
     @pattern.reload 
     
     assert_equal "/uploads/#{@pattern.image.dir}/1/preview_1.jpg", @pattern.image.preview_url
  end
  test "image format has right dimensions" do
     @pattern.upload("test/fixtures/images/1.jpg")
     
     @pattern.save
     @pattern.reload
      
     assert_equal @pattern.image.display_format.width, Pattern::PATTERN_FORMAT[:width]
     assert_equal @pattern.image.display_format.height, Pattern::PATTERN_FORMAT[:height]
     assert_equal @pattern.image.display_format.croppable?, Pattern::PATTERN_FORMAT[:croppable]
     assert_equal @pattern.image.display_format.scalable?, Pattern::PATTERN_FORMAT[:scalable]
     
     assert_equal @pattern.image.edit_format.width, Pattern::PATTERN_FORMAT[:width]
     assert_equal @pattern.image.edit_format.height, Pattern::PATTERN_FORMAT[:width]
     assert_equal @pattern.image.display_format.croppable?, Pattern::PATTERN_FORMAT[:croppable]
     assert_equal @pattern.image.edit_format.scalable?, Pattern::PATTERN_FORMAT[:scalable]
     
     
     assert_equal @pattern.image.preview_format.width, Pattern::PATTERN_FORMAT[:width]
     assert_equal @pattern.image.preview_format.height, Pattern::PATTERN_FORMAT[:width]
     assert_equal @pattern.image.preview_format.croppable?, Pattern::PATTERN_FORMAT[:croppable]
     assert_equal @pattern.image.preview_format.scalable?, Pattern::PATTERN_FORMAT[:scalable]
      
  end
  
  
end
