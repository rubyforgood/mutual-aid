# frozen_string_literal: true

class BaseForm < ActiveInteraction::Base
  def self.build params
    run! params
  end

  def given_inputs
    inputs.select{|key| given? key }
  end
end
