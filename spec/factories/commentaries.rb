FactoryBot.define do
  factory :commentary do
    content { "MyText" }
    user { association(:user) }
    post { association(:post) }
  end
end
