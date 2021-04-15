module NotUsingPunditYet
  extend ActiveSupport::Concern

  included do
    skip_after_action :verify_authorized
    skip_after_action :verify_policy_scoped
  end
end
