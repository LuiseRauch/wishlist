include RandomData

FactoryGirl.define do
  factory :wish do
    title RandomData.random_sentence
    body RandomData.random_paragraph
  end
end
