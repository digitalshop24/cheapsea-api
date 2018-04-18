class Offers::UpdateService
  include Interactor

  def call
    pre_initialize

    validation = Offers::UpdateValidation.call(params)
    if validation.errors.present?
      context.fail!(errors: validation.errors)
    end

    validate_transfers

    ActiveRecord::Base.transaction do
      if offer.update(params)
        update_transfers
      else
        context.fail!(errors: offer.errors.full_messages)
      end
    end
  end

  private

  attr_reader :user, :offer, :params, :transfers_params

  def pre_initialize
    @user = context.user
    @offer = context.offer
    @params = context.params
    @transfers_params = ConvertService.remove_params_from_array_with_hash(
      JSON.parse(context.transfers_params),
      %w[offer_id user_id]
    ) if context.transfers_params.present?
  end

  def validate_transfers
    return if transfers_params.nil?

    transfers_params.each do |params|
      validation = Transfers::UpdateValidation.call(params)
      context.fail!(errors: validation.errors) if validation.errors.present?
    end
  end

  def update_transfers
    return if transfers_params.nil?

    transfers_params.each do |params|
      transfer = offer.transfers.find_by(id: params['id'])
      next if transfer.nil?
      raise Pundit::NotAuthorizedError unless TransferPolicy.new(user, transfer).update?
      unless transfer.update(params)
        context.fail!(errors: transfer.errors.full_messages)
      end
    end
  end
end