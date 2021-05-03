class HideRestrictedFieldsTransformer < Blueprinter::Transformer
  def transform(hash, object, options)
    policy = Pundit.policy(options[:current_user], object)
    return hash unless policy && policy.respond_to?(:restricted_attributes)

    policy.restricted_attributes.each do |attr|
      hash[attr] = nil
    end
  end
end
