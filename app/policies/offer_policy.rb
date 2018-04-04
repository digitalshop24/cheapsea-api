class OfferPolicy < ApplicationPolicy
  def index
    super
  end

  def create
    super
  end

  def update
    admin? || moderator? || owner?
  end

  def destroy
    admin? || moderator? || owner?
  end
end
