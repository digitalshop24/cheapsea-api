class Filters::Base
  def initialize(params={})
    @params = params
    @relation = nil
  end

  def call
    raise "@relation not initialized at #{self.class.name}" if relation.nil?

    results = relation.where(nil)
    return results if params.empty?

    params.each do |key, value|
      results = results.where("#{key}": value) if value.present?
    end

    results
  end

  protected

  attr_reader :relation, :params
end
