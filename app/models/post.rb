class Post < ApplicationRecord
  belongs_to :user
<<<<<<< Updated upstream
=======
  has_one_attached :audio  
  has_many :comments, dependent: :destroy
  validates :title, presence: true

  validates :audio, content_type: {
    in: ['audio/mpeg', 'audio/wav'],
    message: 'はMP3またはWAV形式のファイルをアップロードしてください'
  }
>>>>>>> Stashed changes
end

