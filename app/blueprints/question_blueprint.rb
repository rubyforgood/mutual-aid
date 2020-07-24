class QuestionBlueprint < Blueprinter::Base
  identifier :id

  fields(
    :name,
    :input_type,
    :is_required,
    :option_list,
    :hint_text,
  )
end
