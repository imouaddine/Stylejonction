require 'test_helper'

class PatternBackgroundTest < ActiveSupport::TestCase
  def setup 
     @pattern = Pattern.create 
     @background = Factory.create(:pattern_background, :pattern => @pattern)
  end
  test "PatternBackground & Pattern realtion works properly" do
    
    @background.save
  
    @background.reload
    
    assert_equal @pattern, @background.pattern
  end
  
  
end
