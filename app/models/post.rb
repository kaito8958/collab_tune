class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :audio
  has_many :comments, dependent: :destroy
  has_many :collaborations, dependent: :destroy

  validates :title, presence: true

  validate :acceptable_audio

  private

  def acceptable_audio
    return unless audio.attached?

    unless audio.content_type.in?(%w(audio/mpeg))
      errors.add(:audio, 'はMP3形式のファイルをアップロードしてください')
    end
  end
end
