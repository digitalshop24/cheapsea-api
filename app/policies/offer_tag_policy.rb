class OfferTagPolicy < ApplicationPolicy
  def destroy?
    (admin? || moderator? || owner?) if super
  end

  def create?
    super
  end
end
