require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_has_a_full_name
    max = User.new(:first_name => "Max",
                   :last_name  => "Pain")

    assert_equal "Max Pain", max.full_name
  end


end
