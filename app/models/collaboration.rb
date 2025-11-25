class Collaboration < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :receiver,  class_name: 'User'
  belongs_to :post
  has_one :chat_room, dependent: :destroy

  validates :status, inclusion: { in: %w[pending accepted rejected] }
  validates :message, presence: true
  validates :requester_id, uniqueness: { scope: [:receiver_id, :post_id], message: 'はすでにこの投稿に申請しています' }

  scope :pending,  -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :rejected, -> { where(status: 'rejected') }
end
