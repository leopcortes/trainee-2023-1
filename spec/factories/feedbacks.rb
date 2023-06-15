FactoryBot.define do
  factory :feedback do
    like { false }
    post { association(:post) }
  end
end
