class RemoveGenreFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :genre, :string
  end
end
