class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sent_collaborations, class_name: "Collaboration", foreign_key: :requester_id, dependent: :destroy
  has_many :received_collaborations, class_name: "Collaboration", foreign_key: :receiver_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :icon

  def performance_skills
    super || []
  end

  def production_skills
    super || []
  end

  def looking_for_skills
    super || []
  end

  def links
    super || {}
  end
end
