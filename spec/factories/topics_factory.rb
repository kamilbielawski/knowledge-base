FactoryGirl.define do
  factory :topic do
    sequence(:name) {|i| "Topic #{i}"}
  end
end
