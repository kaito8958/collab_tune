class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :audio
  has_many :comments, dependent: :destroy
  has_many :collaborations, dependent: :destroy

  validates :title, presence: true
  validate :acceptable_audio

  enum status: { recruiting: 0, closed: 1 }

  validates :status, presence: true
  validate :recruiting_requires_details_and_skill

  # ===============================
  #  ActiveHash の紐付け補助
  # ===============================
  def looking_for_skills
    return [] unless looking_for_skill_ids.is_a?(Array)

    looking_for_skill_ids.map { |id| LookingForSkill.find_by(id: id) }.compact
  end

  def genres
    return [] unless genre_ids.is_a?(Array)

    genre_ids.map { |id| Genre.find_by(id: id) }.compact
  end

  private

  def acceptable_audio
    return unless audio.attached?

    return if audio.content_type.in?(%w[audio/mpeg])

    errors.add(:audio, 'はMP3形式のファイルをアップロードしてください')
  end

  def recruiting_requires_details_and_skill
    return unless recruiting?

    errors.add(:looking_for_skill_ids, 'を1つ以上選んでください') if looking_for_skill_ids.blank?

    return unless recruiting_details.blank?

    errors.add(:recruiting_details, 'を入力してください')
  end
end
