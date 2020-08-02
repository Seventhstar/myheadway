FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "Author #{n} name" }
  end
end
