include RandomData

FactoryGirl.define do
  factory :wish do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    url RandomData.random_url
    price RandomData.random_number
  end
end
