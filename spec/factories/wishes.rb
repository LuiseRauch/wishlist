include RandomData

FactoryGirl.define do
  factory :wish do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    url RandomData.random_url
    price_cents RandomData.random_number
    # price_cents(Money.new(0, Project::DEFAULT_CURRENCY))
    rating RandomData.random_rating
  end
end
