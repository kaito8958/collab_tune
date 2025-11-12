class UpdateUserProfileFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :instrument, :string if column_exists?(:users, :instrument)
    remove_column :users, :genre, :string if column_exists?(:users, :genre)

    add_column :users, :daw, :string unless column_exists?(:users, :daw)
    add_column :users, :performance_skills, :json unless column_exists?(:users, :performance_skills)
    add_column :users, :production_skills, :json unless column_exists?(:users, :production_skills)
    add_column :users, :looking_for_skills, :json unless column_exists?(:users, :looking_for_skills)
    add_column :users, :goal, :text unless column_exists?(:users, :goal)
    add_column :users, :links, :json unless column_exists?(:users, :links)

    rename_column :users, :profile, :introduction if column_exists?(:users, :profile)
  end
end
