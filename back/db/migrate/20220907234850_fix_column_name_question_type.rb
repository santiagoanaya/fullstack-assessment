class FixColumnNameQuestionType < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :questions, :type, :question_type
  end
end
