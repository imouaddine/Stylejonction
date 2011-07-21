class PatternBackground < ActiveRecord::Base
  has_many :portfolios, :as => :background
  belongs_to :pattern
  
   def to_json
      self.to_json(:include => :pattern)
   end
end
