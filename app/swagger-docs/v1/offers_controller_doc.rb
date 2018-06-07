module V1::OffersControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :offers, 'Offer Management'

    def self.params(api)
      ApiController.credentials(api)
      api.param :form, 'offer[offer_type]', :string, :optional, 'Offer type: airplane, trane, bus, car_rent'
      api.param :form, 'offer[discount_type]', :string, :optional, 'Discount type: hot, seasonal, erroneous, other'
      api.param :form, 'offer[airline_id]', :string, :optional, 'Airline id'
      api.param :form, 'offer[transfers_count]', :integer, :optional, 'Transfers count'
      api.param :form, 'offer[date_from]', :string, :optional, 'Start date of offer'
      api.param :form, 'offer[date_to]', :string, :optional, 'End date of offer'
      api.param :form, 'offer[date_end]', :string, :optional, 'Date when offer will archived automaticly'
      api.param :form, 'offer[discount_rate]', :integer, :optional, 'Discount rate'
      api.param :form, 'offer[description]', :string, :optional, 'Description'
      api.param :form, 'offer[two_sides]', :string, :optional, 'Two sides?'
      api.param :form, 'offer[from_airport_id]', :integer, :optional, 'ID of airport'
      api.param :form, 'offer[to_airport_id]', :integer, :optional, 'ID of airport'
      api.param :form, 'offer[quality]', :integer, :optional, 'Quality: unknown(default), bad, normal, good'
    end

    def self.filter_params(api, key = nil)
      api.param :query, "#{key}[page]", :integer, :optional, 'Page'
      api.param :query, "#{key}[order]", :string, :optional, 'Order by. For example "price ASC"'
      api.param :query, "#{key}[name]", :string, :optional, 'Name. (\'name ILIKE ? or name_auto ILIKE ?\')'
      api.param :query, "#{key}[offer_type]", :string, :optional, 'Offer type: airplane, trane, bus, car_rent'
      api.param :query, "#{key}[discount_type]", :string, :optional, 'Discount type: hot, seasonal, erroneous, other'
      api.param :query, "#{key}[airline_id]", :string, :optional, 'Airline id'
      api.param :query, "#{key}[transfers_count]", :integer, :optional, 'Transfers count'
      api.param :query, "#{key}[date_from]", :string, :optional, 'Start date of an offer'
      api.param :query, "#{key}[date_to]", :string, :optional, 'End date of an offer'
      api.param :query, "#{key}[date_end]", :string, :optional, 'Date when offer will be archived automatically'
      api.param :query, "#{key}[price]", :string, :optional, 'Price by range or particular price. Example: 100-300 or just 100'
      api.param :query, "#{key}[price_currency]", :integer, :optional, 'Currency type: RUB, USD, EUR. RUB by default.'
      api.param :query, "#{key}[discount_rate]", :integer, :optional, 'Discount rate'
      api.param :query, "#{key}[two_sides]", :string, :optional, 'Two sides'
      api.param :query, "#{key}[origin]", :string, :optional, 'Origin. Countries and cities ids. Url example: url?origin[countries]=1,2,3&origin[cities]=1,2,3'
      api.param :query, "#{key}[destination]", :string, :optional, 'Destination. Countries and cities ids. Url example: url?destination[countries]=1,2,3&destination[cities]=1,2,3'
      api.param :query, "#{key}[main]", :boolean, :optional, 'On main dashboard?'
    end

    def self.required_id(api)
      api.param :path, :id, :integer, :required, 'Offer Id'
    end

    swagger_api :create do |api|
      summary 'Create a new Offer item'
      API::V1::OffersController.params(api)
      api.param :form, 'offer[name]', :string, :required, 'Name'
      api.param :form, 'offer[is_direct]', :boolean, :required, 'Is a direct flight?'
      api.param :form, 'offer[origin_id]', :integer, :required, 'Origin City id'
      api.param :form, 'offer[destination_id]', :integer, :required, 'Destination City id'
      api.param :form, 'offer[price]', :integer, :required, 'Price'
      api.param :form, 'offer[price_currency]', :integer, :required, 'Currency type: RUB, USD, EUR'
      api.param :form, 'offer[transfers_attributes]', :string, :optional, 'Create transfers. ex: "transfers_attributes"=>{"0"=>{"city_id"=>"1", "airline_id"=>"1"}, "1"=>{"city_id"=>"2"}}}'
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :update do |api|
      summary 'Update an Offer item'
      API::V1::OffersController.required_id(api)
      API::V1::OffersController.params(api)
      api.param :form, 'offer[name]', :string, :optional, 'Name'
      api.param :form, 'offer[is_direct]', :boolean, :optional, 'Is a direct flight?'
      api.param :form, 'offer[price]', :integer, :optional, 'Price'
      api.param :form, 'offer[price_currency]', :integer, :optional, 'Currency type: RUB, USD, EUR'
      api.param :form, 'offer[origin_id]', :integer, :optional, 'Origin City id'
      api.param :form, 'offer[destination_id]', :integer, :optional, 'Destination City id'
      api.param :form, 'offer[status]', :string, :optional, 'Status: draft, published'
      api.param :form, 'offer[transfers_attributes]', :string, :optional, 'Update transfers. ex: "transfers_attributes"=>{"0"=>{"id"=>"1", "city_id"=>"1", "airline_id"=>"1"}, "1"=>{"id"=>"2", "city_id"=>"2"}}}'
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :destroy do |api|
      summary 'Destroy an Offer item'
      API::V1::OffersController.required_id(api)
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :index do |api|
      summary 'All offers'
      API::V1::OffersController.filter_params(api)
    end

    swagger_api :show do |api|
      summary 'Show an offer'
      API::V1::OffersController.required_id(api)
    end
  end
end
