class API::V1::ProfilesController < ApiController
  before_action :authenticate_user, only: :show

  swagger_controller :profiles, 'Profile Management'

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

  swagger_api :create do |api|
    summary 'Create profile'
    api.param :form, 'profile[email]', :string, :required, 'Email'
    api.param :form, 'profile[password]', :string, :required, 'Password'
    api.param :form, 'profile[password_confirmation]', :string, :required, 'Password confirmation'
    api.param :form, 'profile[name]', :string, :required, 'Name'
    api.param :form, 'profile[phone]', :string, :optional, 'Phone'
    response :unauthorized
    response :unprocessable_entity
  end

  swagger_api :show do |api|
    summary 'Show profile'
    ApiController.credentials(api)
    response :unauthorized
    response :unprocessable_entity
  end

  private

  def profile_params
    params.require(:profile).permit(%i[email password password_confirmation name phone])
  end
end
