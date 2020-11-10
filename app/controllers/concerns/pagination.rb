# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  include Pagy::Frontend
  include Pagy::Backend

  included do
    helper_method :pagy_bulma_nav
  end
end
