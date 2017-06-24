FactoryGirl.define do
  factory :faq do
    question FFaker::Lorem.word
    answer FFaker::Lorem.phrase
    company
  end
end