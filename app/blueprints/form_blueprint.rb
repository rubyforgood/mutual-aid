class FormBlueprint < Blueprinter::Base
  identifier :id

  association :questions, blueprint: QuestionBlueprint do |form|
    CustomFormQuestion.for_form(form).ordered
  end
end
