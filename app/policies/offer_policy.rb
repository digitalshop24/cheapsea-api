class OfferPolicy < ApplicationPolicy
  def index?
    super
  end

  def create?
    super
  end

  def update?
    (admin? || moderator? || owner?) if super
  end

  def destroy?
    (admin? || moderator? || owner?) if super
  end
end
