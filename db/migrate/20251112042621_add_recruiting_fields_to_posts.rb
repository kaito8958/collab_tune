class AddRecruitingFieldsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :status, :integer
    add_column :posts, :recruiting_details, :text
  end
end
