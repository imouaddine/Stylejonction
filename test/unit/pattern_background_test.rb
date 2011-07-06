require 'test_helper'

class PatternBackgroundTest < ActiveSupport::TestCase
  test "PatternBackground & Pattern realtion works properly" do
    background = Factory.create(:pattern_background)
    pattern = Pattern.create :pattern => "This is a pattern"

    background.pattern = pattern
    background.save; background.reload

    assert_equal "This is a pattern", background.pattern.pattern
  end
end
