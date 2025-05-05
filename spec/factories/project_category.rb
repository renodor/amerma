# This will guess the User class
FactoryBot.define do
  factory :project_category do
    sequence(:name) { |n| "project-category-#{n}" }
    sequence(:position) { |n| n }
  end
end
