class CreateCustomFormQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_form_questions do |t|
      t.string :name
      t.string :input_type
      t.boolean :is_required
      t.string :form_type
      t.string :option_list
      t.string :hint_text
      t.string :display_order

      t.timestamps
    end
  end
end
