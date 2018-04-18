class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record, *)
    @user = user
    @record = record
  end

  def index?
    granted?(:index)
  end

  def show?
    granted?(:show)
  end

  def create?
    granted?(:create)
  end

  def new?
    create?
  end

  def update?
    granted?(:update)
  end

  def edit?
    update?
  end

  def destroy?
    granted?(:destroy)
  end

  def scope
    Pundit.policy_scope!(user, klass(record))
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  def admin?
    user&.admin?
  end

  def moderator?
    user&.moderator?
  end

  def klass(record)
    record.respond_to?(:superclass) ? record : record.class
  end

  def granted?(action)
    Users::AccessCheckService.new(user: user, klass: klass(record), action: action).call
  end

  def owner?
    record.user_id == user.id
  end
end
