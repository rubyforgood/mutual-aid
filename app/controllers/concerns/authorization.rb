module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  module ClassMethods
    def unsecured_action(*actions)
      actions = actions.map(&:to_sym)

      if actions.include?(:index)
        actions.delete(:index)
        skip_after_action(:verify_policy_scoped, only: :index)
      end

      skip_after_action(:verify_authorized, only: actions)
    end
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = "Sorry, you're not authorized to do that."
    Rails.logger.error "[UNAUTHORIZED] #{exception}. (#{policy_name}.#{exception.query})"
    respond_to do |format|
      format.html { render 'errors/403.html.erb', layout: "application", status: 403 }
      format.xml  { head 403 }
      format.any  { head 403 }
    end
  end
end