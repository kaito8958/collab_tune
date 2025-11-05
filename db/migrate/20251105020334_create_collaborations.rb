class CreateCollaborations < ActiveRecord::Migration[7.1]
  def change
    create_table :collaborations do |t|
      t.bigint :requester_id, null: false
      t.bigint :receiver_id, null: false
      t.references :post, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"
      t.text :message, null: false

      t.timestamps
    end

    # 外部キー制約を追加
    add_foreign_key :collaborations, :users, column: :requester_id
    add_foreign_key :collaborations, :users, column: :receiver_id
  end
end
