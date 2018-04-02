class GeoController < ApiController
  swagger_controller :geo, 'Geo', resource_path: '/geo'

  swagger_api :autocomplete do |api|
    summary 'Autocomplete'
    notes 'City'
    api.param :form, 'input', :string, :optional, 'Query search'
    api.param :form, 'lat', :string, :optional, 'Latitude'
    api.param :form, 'lng', :string, :optional, 'Longitude'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  def autocomplete
    if params[:input].blank?
      render json: Geo::DefaultValueObject.call
    else
      render json: Geo::AutocompleteService.new(params[:input], params[:lat], params[:lng]).call
    end
  end
end
