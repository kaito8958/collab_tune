FactoryBot.define do
  factory :collaboration do
    association :requester, factory: :user
    association :receiver, factory: :user
    association :post

    status  { 'pending' }
    message { 'コラボお願いできますか？' }
  end
end
