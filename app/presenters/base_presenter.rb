class BasePresenter < SimpleDelegator
  attr_reader :h

  def initialize object, view_context
    super object
    @h = view_context
  end
end
