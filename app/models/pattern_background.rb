class PatternBackground < ActiveRecord::Base
  has_many :portfolios, :as => :background
  belongs_to :pattern
   
end
