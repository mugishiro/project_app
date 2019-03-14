class AddUserIdToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_id, :boolean, default: false, null: false
  end
end
