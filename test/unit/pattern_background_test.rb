require 'test_helper'

class PatternBackgroundTest < ActiveSupport::TestCase
  
  test "PatternBackground & Pattern realtion works properly" do
    background = Factory.create(:pattern_background)
    
    pattern = Pattern.new 
    pattern.pattern.store!(File.open(File.join(Rails.root, "public/assets/images/pattern_backgrounds/1.png")))
    pattern.save
    
    background.pattern = pattern
    assert background.save, background.errors.inspect
    
    background.reload
    
    assert_equal background.pattern.pattern.url, "/uploads/pattern/pattern/1.png"
  end
  
end
