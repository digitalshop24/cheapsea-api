class Users::AccessCheckService
  PERMISSIONS = {
    member: {
      Offer: %i[index]
    },
    agent: {
      Offer: %i[index create update destroy],
      Transfer: %i[update],
      OfferTag: %i[create destroy]
    },
    moderator: {
      Offer: %i[index create update destroy],
      Transfer: %i[index create update destroy],
      Collection: %i[create destroy],
      OfferCollection: %i[create destroy],
      Tag: %i[create destroy],
      OfferTag: %i[create destroy]
    },
    admin: {
      Offer: %i[index create update destroy],
      Transfer: %i[index create update destroy],
      Collection: %i[create destroy],
      OfferCollection: %i[create destroy],
      Tag: %i[create destroy],
      OfferTag: %i[create destroy]
    },
    guest: {
      Offer: %i[index]
    }
  }.freeze

  def initialize(user:, klass:, action:)
    @user = user || OpenStruct.new(role: 'guest')
    @klass = klass
    @action = action
  end

  def call
    class_name = klass.name.to_sym
    user_role = user.role.to_sym
    PERMISSIONS[user_role][class_name]&.include?(action)
  end

  private

  attr_reader :user, :klass, :action
end
