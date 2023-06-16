FactoryBot.define do
  factory :commentary do
    content { "MyText" }
    post { association(:post) }
  end
end
