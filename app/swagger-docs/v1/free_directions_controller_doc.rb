module V1::FreeDirectionsControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :free_directions, 'Free directions management'

    swagger_api :index do
      summary 'All free directions'
    end
  end
end
