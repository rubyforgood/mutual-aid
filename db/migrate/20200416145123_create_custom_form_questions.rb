class CreateCustomFormQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_form_questions do |t|
      t.string :name
      t.string :input_type
      t.boolean :is_required, null: false, default: true
      t.string :form_type
      t.text :option_list, default: [], array: true
      t.string :hint_text
      t.string :display_order

      t.timestamps
    end
  end
end
