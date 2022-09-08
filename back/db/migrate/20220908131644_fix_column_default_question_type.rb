class FixColumnDefaultQuestionType < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:questions, :question_type, from: nil, to: 0)
  end
end
