module ImageExtensions
  def has_image
    belongs_to :image, :dependent => :destroy
    attr_accessible :image
    include InstanceMethods
  end
  module InstanceMethods
    def upload(file)
      setup_image()
      image.upload(file)
      image.save()
    end
    def remove_file!
      image.remove_image!
      image.save
    end
  end
  
end
ActiveRecord::Base.extend ImageExtensions
