class ChangeDataEvaluationToMicropost < ActiveRecord::Migration[5.0]
  def change
    change_column :microposts, :evaluation, 'float USING CAST(evaluation AS float)'
  end
end
