class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sent_collaborations, class_name: 'Collaboration', foreign_key: :requester_id, dependent: :destroy
  has_many :received_collaborations, class_name: 'Collaboration', foreign_key: :receiver_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :icon

  validates :nickname, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX }, if: :validate_password_format?

  def validate_password_format?
    password.present? && (new_record? || will_save_change_to_password?)
  end

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

  def genres
    super || []
  end
end
