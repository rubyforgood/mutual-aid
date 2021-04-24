class PersonPresenter < BasePresenter
  def name
    policy.read? ? super : nil
  end

  private

  def policy
    @policy ||= PersonPolicy.new context, object
  end
end
