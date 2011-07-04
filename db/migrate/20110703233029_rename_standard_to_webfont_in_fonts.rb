class RenameStandardToWebfontInFonts < ActiveRecord::Migration
  def up
    rename_column :fonts, :standard, :webfont
    add_column :portfolios, :body_font_id, :integer
    rename_column :portfolios, :font_id, :title_font_id
    
  end

  def down
    rename_column :fonts, :webfont, :standard
    remove_column :portfolios, :body_font_id
    rename_column :portfolios, :title_font_id, :font_id
  end
end
