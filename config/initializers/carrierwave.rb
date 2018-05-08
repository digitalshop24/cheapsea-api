require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'

  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_KEY_ID'],
      aws_secret_access_key: ENV['S3_ACCESS_KEY'],
      region:                'eu-central-1',
  }
  config.storage        = :fog
  config.fog_public     = true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
  config.fog_directory  = 'cheapsea'
end
