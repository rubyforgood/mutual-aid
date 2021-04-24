class ContributionPresenter < BasePresenter
  def view_path
    h.contribution_path id
  end

  def person
    PersonPresenter.new(super, h)
  end
end
