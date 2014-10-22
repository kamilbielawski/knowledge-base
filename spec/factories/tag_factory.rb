FactoryGirl.define do
  factory :tag do
    sequence(:name) {|i| "Tag #{i}"}
  end
end
