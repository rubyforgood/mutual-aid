class AddFormHookToCustomFormQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :custom_form_questions, :form_hook, :string, index: true
  end
end
