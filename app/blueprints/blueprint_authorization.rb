# Provides authorization during serialization,
# leveraging existing pundit policies
#
# To add authorization to a blueprint (serializer):
# 1. Implement a `restricted_attributes` method in the related policy.
# 2. `extend BlueprintAuthorization` in the blueprint.
#
# See PersonBlueprint for a working example.
#
# Note that Blueprinter already supports custom
# [Transforms](https://github.com/procore/blueprinter#example).
# These could be a simpler integration point, but currently need to be
# applied both at the top level of a blueprint and in each nested view.
# We felt this would be too easy to miss.
#
# This issue has been noted in blueprinter here:
# https://github.com/procore/blueprinter/pull/247/files
#
module BlueprintAuthorization
  def self.extended(blueprint)
    blueprint.class_eval do
      transform Transformer
    end
  end

  def view(*options, &block)
    super(*options) do
      transform Transformer
      block.call
    end
  end

  class Transformer < Blueprinter::Transformer
    def transform(hash, object, options)
      policy = Pundit.policy(current_user_from(options), object)
      policy.restricted_attributes.each do |attr|
        hash[attr] = nil
      end
    end

    private

    def current_user_from(options)
      unless options.key? :current_user
        fail ArgumentError, '`current_user` option must be given when rendering a serializer with BlueprintAuthorization'
      end
      options[:current_user]
    end
  end
end
