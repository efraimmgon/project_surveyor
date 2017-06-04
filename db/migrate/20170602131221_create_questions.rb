class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :body
      # type can be:
      # radio, checkbox
      t.string :input_type
      t.boolean :is_required
      t.integer :survey_id

      t.timestamps
    end

    add_index :questions, :survey_id
  end
end
