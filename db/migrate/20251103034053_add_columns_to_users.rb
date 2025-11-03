class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname, :string, null: false
    add_column :users, :profile, :text
    add_column :users, :instrument, :string
    add_column :users, :genre, :string
  end
end
