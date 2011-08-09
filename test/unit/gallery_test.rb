require 'test_helper'

class GalleryTest < ActiveSupport::TestCase
  
  test "validation" do
    gallery = Gallery.new(:project_id => 1)
    assert_equal false, gallery.save
    
    gallery.display_preference = "SSS"
    assert_equal false, gallery.save
    
    gallery.display_preference = "mosaic"
    gallery.title ="New title"
    assert_equal true, gallery.save, gallery.errors.inspect
  end
  
  
  
end
