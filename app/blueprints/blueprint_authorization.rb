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
      policy = Pundit.policy(options[:current_user], object)
      policy.restricted_attributes.each do |attr|
        hash[attr] = nil
      end
    end
  end
end
