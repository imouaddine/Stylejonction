require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "image default " do
    
    image = Image.new
    image.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/1.jpg")))

    assert_equal  true, image.save, image.errors.inspect
    
    image.reload
    
    assert image.thumb_format, "thumb should be created on initialization"
    assert image.original_format, "original should be created on initialization"

    assert_equal false, image.thumb_format.scale_to_fit?
    
  end
  test "test upload image" do
    image = Image.new
    image.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/1.jpg")))
    
    assert_equal  true, image.save, image.errors.inspect
    
    image.reload
    
    assert_equal "/uploads/image/image/thumb_1.jpg", image.image.url(:thumb)
    assert_equal "/uploads/image/image/1.jpg", image.image.url
    
  end
  
  test "test crop image" do 
    
    image = Image.create
    image.image.store!(File.open(File.join(Rails.root, "public/assets/images/projects/1.jpg")))
    image.crop( 10, 20)
    
    image.reload
    
   
    
    
    assert_equal 10, image.thumb_format.crop_x
    assert_equal 20, image.thumb_format.crop_y
  end
  
  
  
end