class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Defaults are all false (fully-locked down)
  # but we are currently fully-open, so changing the defaults to true
  # This needs to be :100: changed ASAP.
  DEFAULT_PERMISSION = true
  def index?
    DEFAULT_PERMISSION
  end

  def show?
    DEFAULT_PERMISSION
  end

  def create?
    DEFAULT_PERMISSION
  end

  def new?
    create?
  end

  def update?
    DEFAULT_PERMISSION
  end

  def edit?
    update?
  end

  def destroy?
    DEFAULT_PERMISSION
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
