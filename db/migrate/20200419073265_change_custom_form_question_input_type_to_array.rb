class ChangeCustomFormQuestionInputTypeToArray < ActiveRecord::Migration[6.0]
  def change
    remove_column :custom_form_questions, :option_list, :string
    add_column :custom_form_questions, :option_list, :text, default: [], array: true
  end
end
