FactoryBot.define do
  factory :post do
    association :user # Post.user を作る

    title       { Faker::Music::RockBand.song }
    description { Faker::Lorem.sentence }
    tempo       { Faker::Number.between(from: 60, to: 180) }

    status      { :closed } # デフォルトは安全な closed にする

    # recruiting と closed の状態で切り替えられるトrait
    trait :recruiting do
      status { :recruiting }
      looking_for_skill_ids { [1] } # ActiveHash の ID（適当に1つ）
      recruiting_details { 'ギターを募集しています' }
    end
  end
end
