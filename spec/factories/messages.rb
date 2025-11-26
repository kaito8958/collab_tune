FactoryBot.define do
  factory :message do
    content { 'こんにちは！' }
    read { false }

    association :user
    association :chat_room
  end
end
