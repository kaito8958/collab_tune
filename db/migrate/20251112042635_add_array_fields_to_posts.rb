class AddArrayFieldsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :looking_for_skill_ids, :json
    add_column :posts, :genre_ids, :json
  end
end
