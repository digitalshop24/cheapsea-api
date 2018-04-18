class TransferPolicy < ApplicationPolicy
  def update?
    (admin? || moderator? || owner?) if super
  end
end
