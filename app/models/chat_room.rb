class ChatRoom < ApplicationRecord
  belongs_to :collaboration
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many :messages, dependent: :destroy
end
