class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.integer :choice_id

      t.timestamps
    end

    add_index :responses, [:question_id, :choice_id]
  end
end
