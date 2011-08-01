require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def setup 
    @image = Image.new(:dir => 'test')
  end
  test "image has right default" do
    
    assert @image.display_format, "display format should be created on initialization"
    assert @image.edit_format, "edit format should be created on initialization"
    assert @image.preview_format, "preview format should be created on initialization"
    
    assert_equal  true, @image.save, @image.errors.inspect
    
    @image.reload
    
    assert @image.display_format, "display format should be created on initialization"
    assert @image.edit_format, "edit format should be created on initialization"
    assert @image.preview_format, "preview format should be created on initialization"
   
   
    assert_equal false, @image.preview_format.scale_to_fit?
    
  end
  test "test upload image" do
    assert_equal false, @image.uploaded?
    
    @image.upload "test/fixtures/images/1.jpg"
    assert_equal  true, @image.save, @image.errors.inspect
    
    @image.save
    
    @image.reload
    
    assert_equal true, @image.uploaded?
    
    assert_equal "/uploads/#{@image.dir}/display_1.jpg", @image.display_url
    assert_equal "/uploads/#{@image.dir}/edit_1.jpg", @image.edit_url
    assert_equal "/uploads/#{@image.dir}/preview_1.jpg", @image.preview_url
    assert_equal "/uploads/#{@image.dir}/1.jpg", @image.image.url
    
  end
  
  test "test crop image" do 
    
    @image.upload "test/fixtures/images/1.jpg"
    @image.crop( 10, 20)
    
    assert_equal 10,  @image.display_format.crop_x
    assert_equal 20,  @image.display_format.crop_y
    
    assert_equal 10,  @image.preview_format.crop_x
    assert_equal 20,  @image.preview_format.crop_y
    
    assert_equal 0,  @image.edit_format.crop_x
    assert_equal 0,  @image.edit_format.crop_y
  end
  
  
  
end