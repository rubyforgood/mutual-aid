class ApplicationPolicy
  module Utils
    attr_reader :acting_user, :admin_param, :system_settings

    def sys_admin?
      acting_user && acting_user.sys_admin_role? && admin_param != 'false'
    end

    def admin?
      acting_user && acting_user.admin_role? && admin_param != 'false'
    end

    def can_admin?
      admin? || sys_admin?
    end

    private

    # Allowing for context || user simplifies policy specs that don't use additional context.
    def extract(context)
      if context.respond_to?(:user)
        [context.user, context.system_settings, context.admin_param]
      else
        [context, nil, nil]
      end
    end
  end
  include Utils

  class Scope
    include Utils

    attr_reader :original_scope

    def initialize(context, original_scope)
      @acting_user, @system_settings, @admin_param = extract context
      @original_scope = original_scope
    end

    # We default all permissions to false, and expect you to override as needed.
    def resolve
      original_scope.none
    end
  end

  attr_reader :record

  # We've configured pundit to provide a user context (See https://github.com/varvet/pundit/#additional-context).
  def initialize(context, record)
    @acting_user, @system_settings, @admin_param = extract context
    @record = record
  end

  # Pundit has a "policy scope" feature for narrowing down records returned by `Model.all`.
  # Using policy scopes is almost always more secure and more performant than iterating over
  # every returned record with an index action policy.
  # You can override `warn_if_index_used` to false if you've found one of these rare exceptions.
  def index?
    if warn_if_index_used
      fail "please prefer policy scopes to index action policies unless you're really, really sure"
    end
    false
  end
  private def warn_if_index_used
    !Rails.env.production?
  end

  # By default, we group permissions into:
  #   - read (show)
  #   - add (new/create)
  #   - change (edit/update)
  #   - delete (destroy)
  # We recommend that you override read?/add?/change?/delete? rather than action-level policies.
  def show?;     read?;    end
  def create?;   add?;     end
  def new?;      add?;     end
  def update?;   change?;  end
  def edit?;     change?;  end
  def destroy?;  delete?;  end

  # We default all permissions to false, and expect you to override as needed.
  private def read?;    false;  end
  private def add?;     false;  end
  private def change?;  false;  end
  private def delete?;  false;  end
end
