module PortfolioHelper
  def font_link(portfolio, font, selected = false)
    class_name = 'selected' if selected
    link_to font.name, '#', :class => "select_font #{class_name}" , :style => "font-family: #{font.name}", 'data-id' => "#{font.id}"
  end
end
