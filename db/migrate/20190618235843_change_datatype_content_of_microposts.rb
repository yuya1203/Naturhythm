class ChangeDatatypeContentOfMicroposts < ActiveRecord::Migration[5.0]
  def change
    change_column :microposts, :content, :text
  end
end
