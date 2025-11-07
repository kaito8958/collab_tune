class RemoveCurrentRoomIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :current_room_id, :integer
  end
end
