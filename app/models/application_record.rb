# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_or_new id
    return new if id.nil?
    find_by(id: id) || new
  end
end
