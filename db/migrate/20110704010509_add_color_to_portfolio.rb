class AddColorToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :title_color, :string
    add_column :portfolios, :body_color, :string
  end
end
