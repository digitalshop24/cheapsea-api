class API::AirportsController < ApiController
  include AirportsControllerDoc

  def autocomplete
    render json: AirportsSearch.new(params).call.limit(20)
  end
end
