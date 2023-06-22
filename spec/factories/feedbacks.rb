FactoryBot.define do
  factory :feedback do
    like { false }
    user { association(:user) }
    post { association(:post) }
  end
end
