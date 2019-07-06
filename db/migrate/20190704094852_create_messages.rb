class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.integer :user_message_id
      t.integer :friend_message_id

      t.timestamps
    end
    add_index :messages, :user_message_id
    add_index :messages, :friend_message_id
  end
end
