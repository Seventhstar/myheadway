FactoryBot.define do
  factory :book do
    sequence(:name) { |n| "Book name #{n}" }    
    author 
  end
end
