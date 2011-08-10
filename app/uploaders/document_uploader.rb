class DocumentUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end
  def extension_white_list
    %w(doc pdf docx ppt pptx rtf txt)
  end
end