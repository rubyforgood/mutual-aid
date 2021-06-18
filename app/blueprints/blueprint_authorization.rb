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
