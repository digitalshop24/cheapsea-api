module CitiesControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :cities, 'Cities'

    swagger_api :autocomplete do
      summary 'Autocomplete cities'
      param :query, :query, :string, :optional, 'Query search by name'
      response :unauthorized
      response :not_acceptable, 'The request you made is not acceptable'
      response :unprocessable_entity
    end
  end
end
