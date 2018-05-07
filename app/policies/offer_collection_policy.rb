class OfferCollectionPolicy < ApplicationPolicy
  def destroy?
    (admin? || moderator?) if super
  end

  def create?
    (admin? || moderator?) if super
  end
end
