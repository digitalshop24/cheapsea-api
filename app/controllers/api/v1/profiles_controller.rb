class API::V1::ProfilesController < ApiController
  before_action :authenticate_user, only: [:show, :geo]

  include V1::ProfilesControllerDoc

  def create
    user = User.new(profile_params)
    if user.save
      render json: user, status: 200
    else
      render json: user.errors.full_messages, status: 500
    end
  end

  def show
    render json: current_user
  end

  def geo
    render json: ThirdParty::Travelpayouts::GeoIpService.call(request.remote_ip)
  end

  private

  def profile_params
    params.require(:profile).permit(%i[email password password_confirmation name phone])
  end
end
