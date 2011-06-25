CarrierWave.configure do |config|
  
  if Rails.env.production?
    config.storage = :s3
    config.s3_access_key_id = 'AKIAINERMVZJFNXDUUBQ'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'stylejonction'
    config.s3_cnamed = true
  elsif Rails.env.development?
    config.storage = :file
  else
    config.storage = :file
    config.enable_processing = false
  end
  
  
  
 
end