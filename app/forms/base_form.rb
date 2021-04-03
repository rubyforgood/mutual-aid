# frozen_string_literal: true

class BaseForm < ActiveInteraction::Base
  def self.build params
    run! params
  end

  def given_inputs
    # FIXME: ActiveInteraction::Base#given? seems to have a bug recognizing multipart date params
    raw_inputs = @_interaction_inputs
    inputs.select do |key|
      given?(key) || (
        raw_inputs.key?(:"#{key}(1i)") &&
        raw_inputs.key?(:"#{key}(2i)") &&
        raw_inputs.key?(:"#{key}(3i)")
      )
    end
  end
end
