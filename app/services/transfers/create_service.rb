class Transfers::CreateService
  include Interactor

  def call
    pre_initialize

    transfer = offer.transfers.new(params.merge(user_id: user.id))
    if transfer.valid?
      transfer.save
    else
      context.fail!(errors: transfer.errors.full_messages)
    end
  end

  private

  attr_reader :offer, :params, :user

  def pre_initialize
    @params = context.params
    @offer = context.offer
    @user = context.user
  end
end
