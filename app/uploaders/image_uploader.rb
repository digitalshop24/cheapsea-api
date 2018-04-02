class ImageUploader < BaseUploader

  version :medium do
    process resize_to_fit: [250, 250]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end