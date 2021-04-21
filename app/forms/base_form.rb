# frozen_string_literal: true

class BaseForm < ActiveInteraction::Base
  def self.build params
    run! params
  end

  def self.filter_keys(source = self)
    hashes, others  = source.filters.partition { |_key, filter| filter.is_a? ActiveInteraction::HashFilter  }
    arrays, scalars = others.partition         { |_key, filter| filter.is_a? ActiveInteraction::ArrayFilter }

    result = scalars.map { |key, _| key }

    return result if hashes.empty? && arrays.empty?
    result << {}

    append_array_keys_to(result.last, arrays)
    append_nested_hash_keys_to(result.last, hashes)

    result
  end

  def self.append_array_keys_to(collector, array_filters)
    array_filters.each do |key, filter|
      collector[key] = []
    end
  end

  def self.append_nested_hash_keys_to(collector, hash_filters)
    hash_filters.each do |key, filter|
      collector[key] = filter.filters.empty? ? {} : filter_keys(filter)
    end
  end

  private_class_method :append_array_keys_to, :append_nested_hash_keys_to

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
