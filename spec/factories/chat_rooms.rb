FactoryBot.define do
  factory :chat_room do
    association :requester, factory: :user
    association :receiver, factory: :user
    association :collaboration
  end
end
