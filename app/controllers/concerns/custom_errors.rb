module CustomErrors
  extend ActiveSupport::Concern

  def forbidden
    render plain: '403 Forbidden', status: :forbidden
  end
end