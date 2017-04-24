include RandomData

FactoryGirl.define do
  factory :list do
    name RandomData.random_name
    description RandomData.random_paragraph
    public true
  end
end
