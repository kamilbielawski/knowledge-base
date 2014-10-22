FactoryGirl.define do
  factory :resource do
    sequence(:name) {|i| "Resource #{i}" }
    sequence(:url) {|i| "http://www.example.com/resources/#{i}.html" }
    topic { Topic.last || create(:topic) }

    factory :resource_with_tag do
      tags { [Tag.last || create(:tag)] }
    end
  end
end
