class Collaboration < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver,  class_name: "User"
  belongs_to :post

  validates :status, inclusion: { in: ["pending", "accepted", "rejected"] }
  validates :message, presence: true
  validates :requester_id, uniqueness: { scope: [:receiver_id, :post_id], message: "はすでにこの投稿に申請しています" }
end
