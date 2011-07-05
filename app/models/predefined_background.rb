class PredefinedBackground < ActiveRecord::Base
  has_many :portfolios, :as => :background
end
