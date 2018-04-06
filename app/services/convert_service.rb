module ConvertService
  def self.json_hash(data)
    data.is_a?(String) ? JSON.parse(data).to_h : data
  end
end