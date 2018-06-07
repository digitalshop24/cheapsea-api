class API::CitiesController < ApiController
  include CitiesControllerDoc

  def autocomplete
    render json: CitiesSearch.new(params).call.limit(20)
  end
end
