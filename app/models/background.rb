class Background < ActiveRecord::Base
  has_many :portfolios

  def name
    "Background #{id}"
  end
end
