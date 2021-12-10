# frozen_string_literal: true

# Provides a way to cast to boolean
#
# Returns true if given any string or symbol that, stripped and downcased, matches:
#   1. True values recognized by YAML.load: %w[y, yes, true, on] (https://yaml.org/type/bool.html)
#   2. The opposites of ActiveRecord::Type::Boolean::FALSE_VALUES -- %w[false, 0, f, off]
# Returns nil if given nil or a blank string
# Returns self if given a boolean
# Returns false given any other string or symbol
#
module ToBoolean
  refine String do
    def to_boolean
      blank? ? nil : strip.downcase.in?(%w[true yes on t y 1])
    end
  end

  refine Symbol do
    def to_boolean
      to_s.to_boolean
    end
  end

  refine(NilClass)   { def to_boolean; self end }
  refine(TrueClass)  { def to_boolean; self end }
  refine(FalseClass) { def to_boolean; self end }
end
