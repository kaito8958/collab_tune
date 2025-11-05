class CreateChatRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_rooms do |t|
      t.references :collaboration, null: false, foreign_key: true
      t.bigint :requester_id, null: false
      t.bigint :receiver_id, null: false

      t.timestamps
    end
  end
end
