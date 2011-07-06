class PredefinedBackground < ActiveRecord::Base
  mount_uploader :background, BackgroundUploader
  has_many :portfolios, :as => :background

end
