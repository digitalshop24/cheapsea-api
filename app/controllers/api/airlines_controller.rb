class API::AirlinesController < ApiController
  include AirlinesControllerDoc

  def autocomplete
    render json: ::AirlinesSearch.new(params).call.limit(20)
  end
end
