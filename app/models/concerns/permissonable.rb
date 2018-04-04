module Permissionable
  PERMISSIONS = {
    agent: {
      Action: %i[index create update]
    },
    moderator: {
      Action: %i[index create update]
    }
  }.freeze

  def has_an_access?(klass, action)
    class_name = klass.name.to_sym
    user_role = self.role.to_sym
    PERMISSIONS[user_role][class_name].include?(action)
  end
end
