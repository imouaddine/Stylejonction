require 'test_helper'

class GalleryTest < ActiveSupport::TestCase
  test "validation" do
    gallery = Gallery.new
    assert_equal false, gallery.save
    
    gallery.display_preference = "SSS"
    assert_equal false, gallery.save
    
    gallery.display_preference = "mosaic"
    assert_equal true, gallery.save
  end
end
