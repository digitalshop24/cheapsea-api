require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'

  #ToDo: вынести креденшены в ENV когда будет figaro от Виталика. Так же подключить реальный репозиторий. (сейчас используется мой)
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     'AKIAINBBJVFFENMCIXIQ', #ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: '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', #ENV['AWS_SECRET_ACCESS_KEY'],
      region:                'us-east-1',
  }
  config.storage        = :fog
  config.fog_public     = true
  config.fog_attributes = { 'Cache-Control' => 'max-age=315576000' }
  config.fog_directory  = 'cheapsea-api'
end
