require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase

  def setup
    @user = Factory.create(:user)
    id = @user.portfolio.id
    @portfolio = Portfolio.find(id)
  end
  test "user association" do
    assert @portfolio.user
    assert_equal @portfolio.user, @user
  end
  test "can create a test object from fg" do
    assert @portfolio.valid?
  end

  test "new portoflio is not published" do
    assert ! @portfolio.published?
  end

  test "save body and title font " do
    @font = Factory :font
    @portfolio.body_font = @font
    @portfolio.save
    assert_equal @font, @portfolio.body_font

  end

  test "test portfolio validation" do
    @portfolio.theme = 1
    assert_equal false, @portfolio.save, "Saving should fail when theme has not a valid value"

    @portfolio.layout = "south"
    assert_equal  false, @portfolio.save

  end
  test "can change portfolio state to published" do
    @portfolio.publish!
    @portfolio.reload
    assert_equal true, @portfolio.published?
  end

  test "predefined background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:predefined_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "PredefinedBackground", portfolio.background_type
  end

  test "custom background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:custom_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "CustomBackground", portfolio.background_type
  end

  test "pattern background association works" do
    portfolio = Factory.create(:portfolio)
    background = Factory.create(:pattern_background)
    portfolio.background = background
    portfolio.save
    portfolio.reload
    assert_equal "PatternBackground", portfolio.background_type
  end


  test "by default portfolio should have default attributes" do
    Factory.create(:predefined_background)
    Factory.create(:font)

    portfolio =  Factory.create(:portfolio)
    
    portfolio.reload

    assert_equal "PredefinedBackground", portfolio.background_type
    assert_equal "left", portfolio.layout
    assert_equal portfolio.theme, "light"
    assert_equal Font.first, portfolio.title_font
    assert_equal Font.first, portfolio.body_font
    assert_not_nil portfolio.predefined_background
    assert_not_nil portfolio.pattern_background
    assert_not_nil portfolio.custom_background
  end

  test "has_custom_background return good value" do
    portfolio = Factory.create(:portfolio)
    assert_equal portfolio.has_custom_background?, false

    user = portfolio.user
    portfolio.background = Factory.create(:custom_background, :user => user )
    assert_equal portfolio.has_custom_background?, true
    
    portfolio.background = Factory.create(:pattern_background, :pattern => Pattern.new)
    assert_equal portfolio.has_custom_background?, false
  end

  test "validate custome background " do
    portfolio = Factory.create(:portfolio)
    not_a_correct_id = 33

    portfolio.update_attributes({custom_background_id: not_a_correct_id})
    assert ! portfolio.valid?
    assert_equal "There's no Custom Background with id = 33", portfolio.errors[:custom_background_id].first
  end

  test "validate predefined background " do
    portfolio = Factory.create(:portfolio)
    not_a_correct_id = 33

    portfolio.update_attributes({predefined_background_id: not_a_correct_id})
    assert ! portfolio.valid?
    assert_equal "There's no Predefined Background with id = 33", portfolio.errors[:predefined_background_id].first
  end

  test "validate pattern background " do
    portfolio = Factory.create(:portfolio)
    not_a_correct_id = 33

    portfolio.update_attributes({pattern_background_id: not_a_correct_id})
    assert ! portfolio.valid?
    assert_equal "There's no Pattern Background with id = 33", portfolio.errors[:pattern_background_id].first
  end

  test "validate proper background_type is set" do
    portfolio = Factory.create(:portfolio)

    portfolio.background = Factory.create(:predefined_background)
    assert_equal "PredefinedBackground", portfolio.background_type

    portfolio.background = Factory.create(:custom_background)
    assert_equal "CustomBackground", portfolio.background_type

    portfolio.background = Factory.create(:pattern_background)
    assert_equal "PatternBackground", portfolio.background_type
  end


 

  
end
