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
      create_transfers(offer)
    else
      context.fail!(errors: offer.errors.full_messages)
    end

    context.result = offer
  end

  private

  attr_reader :user, :params, :transfers_params

  def pre_initialize
    @user = context.user
    @params = context.params
    @transfers_params = JSON.parse(context.transfers_params) if context.transfers_params.present?
  end

  def create_transfers(offer)
    return if transfers_params.nil?
    transfers_params.each do |transfer|
      Transfers::CreateService.call(params: transfer, offer: offer)
    end
  end
end
