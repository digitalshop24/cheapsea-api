class Transfers::CreateService
  include Interactor

  def call
    pre_initialize

    validation = Transfers::CreateValidation.call(params)
    if validation.errors.present?
      context.fail!(errors: validation.errors)
    end

    transfer = offer.transfers.new(params)
    if transfer.valid?
      transfer.save
    else
      context.fail!(errors: transfer.errors.full_messages)
    end
  end

  private

  attr_reader :offer, :params

  def pre_initialize
    @params = context.params
    @offer = context.offer
  end
end
