module BlueprintAuthorization
  def self.extended(blueprint)
    blueprint.class_eval do
      transform HideRestrictedFieldsTransformer
    end
  end

  def view(*options, &block)
    super(*options) do
      transform HideRestrictedFieldsTransformer
      block.call
    end
  end
end
