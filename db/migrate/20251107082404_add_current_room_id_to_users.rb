class AddCurrentRoomIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :current_room_id, :integer
  end
end
