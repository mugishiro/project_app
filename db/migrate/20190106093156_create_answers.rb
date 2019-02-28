class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :post_id
      t.text :content

      t.timestamps
    end
  end
end
