require 'hide_restricted_fields_transformer'

Blueprinter.configure do |config|
  config.default_transformers = [HideRestrictedFieldsTransformer]
end
