class CreateSubmissionResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :submission_responses do |t|
      t.references :submission, null: false, foreign_key: true
      t.references :custom_form_question, null: false, foreign_key: true
      t.boolean :boolean_response
      t.date :date_response
      t.datetime :datetime_response
      t.integer :integer_response
      t.text :text_response
      t.string :string_response, index: true
      t.text :array_response, array: true, default: []

      t.timestamps
    end
  end
end
