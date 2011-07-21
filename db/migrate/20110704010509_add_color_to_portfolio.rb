class AddColorToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :title_color, :string, :default => '333333'
    add_column :portfolios, :body_color, :string, :default => '333333'
  end
end
