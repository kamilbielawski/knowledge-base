FactoryGirl.define do
  factory :resource do
    sequence(:name) {|i| "Resource #{i}" }
    sequence(:url) {|i| "http://www.example.com/resources/#{i}.html" }
    topic { Topic.last || create(:topic) }
  end
end
