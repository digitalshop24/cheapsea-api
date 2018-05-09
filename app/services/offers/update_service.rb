class Offers::UpdateService
  include Interactor

  def call
    pre_initialize

    unless offer.update(params)
      context.fail!(errors: offer.errors.full_messages)
    end
  end

  private

  attr_reader :user, :offer, :params

  def pre_initialize
    @user = context.user
    @offer = context.offer
    @params = context.params
  end
end
