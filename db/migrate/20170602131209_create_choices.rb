class CreateChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :choices do |t|
      t.integer :question_id
      t.text :body

      t.timestamps
    end

    add_index :choices, :question_id
  end
end
