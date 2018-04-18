module ConvertService
  def self.remove_params_from_array_with_hash(arr, params)
    # ex: [{"id"=>"51", "google_place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g", "airline_id"=>"1"}]
    params.each { |key| arr.each { |arr| arr.delete(key) }}
    arr
  end

  def self.remove_params_from_array(arr, params)
    # ex: ['offer_type', 'discount_type', 'name']
    params.each { |key| arr.delete(key) }
    arr
  end
end