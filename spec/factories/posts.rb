FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    user { association(:user) }
  end
end
