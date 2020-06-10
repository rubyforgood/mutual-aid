class CreateFormQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :form_questions do |t|
      t.references :form, null: false, foreign_key: true
      t.references :custom_form_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
