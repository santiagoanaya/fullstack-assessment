class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.integer :type
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
