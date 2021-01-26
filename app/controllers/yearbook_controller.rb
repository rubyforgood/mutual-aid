class YearbookController < AdminController
  def show
    @positions = Position.all
  end
end
