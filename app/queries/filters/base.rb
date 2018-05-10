# This class created for auto filtering simple plain_params like Offer.where(name: name) without any conditions or complex logic

class Filters::Base
  def initialize(params, page)
    @plain_params = params.permit(simple_acessible_params)
    @complex_params = params.permit(complex_acessible_params)
    @page = page
    @relation = nil
  end

  def call
    raise "@relation not initialized at #{self.class.name}. Add @relation = Offer for example." if relation.nil?

    @results ||= relation.all
    return results if plain_params.empty?

    plain_params.each do |key, value|
      @results = results.where("#{key}": value) if value.present?
    end

    results
  end

  protected

  attr_reader :relation, :plain_params, :complex_params, :page, :results

  def relation
    raise 'relation method not implemented. Add this method to calling class and add AR relation, for example Offer.all'
  end

  def simple_acessible_params
    raise 'simple_acessible_params method not implemented. Add this method to calling class and add parameters %i[offer_type] for example.'
  end

  def complex_acessible_params
    raise 'complex_acessible_params method not implemented. Add this method to calling class and add parameters %i[offer_type] for example.'
  end
end
