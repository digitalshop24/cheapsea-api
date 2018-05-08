class Country::SquareUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  process resize_to_fill: [250, 250]
end
