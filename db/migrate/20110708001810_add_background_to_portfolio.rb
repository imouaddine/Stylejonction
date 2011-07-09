class AddBackgroundToPortfolio < ActiveRecord::Migration
  def change
      add_column :portfolios, :pattern_background_id, :integer
      add_column :portfolios, :custom_background_id, :integer
      add_column :portfolios, :predefined_background_id, :integer
  end
end
