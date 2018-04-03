# TODO: add specs

class Offers::CreateService
  include Interactor

  def call
    pre_initialize
    
    validation = Offers::CreateValidation.call(params)
    if validation.errors.present?
      context.fail!(errors: validation.errors)
    end

    offer = user.offers.new(params)
    if offer.valid?
      offer.save
    else
      context.fail!(errors: offer.errors.full_messages)
    end

    context.result = offer
  end

  private

  attr_reader :user, :params

  def pre_initialize
    @user = context.user
    @params = context.params
  end
end
