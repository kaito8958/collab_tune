class AddGenresToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :genres, :json
  end
end
