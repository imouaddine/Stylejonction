class AddBackgroundToPortfolio < ActiveRecord::Migration
  def change
      add_column :portfolios, :background_pattern_id, :integer
      add_column :portfolios, :background_custom_id, :integer
      add_column :portfolios, :background_predefined_id, :integer
  end
end
