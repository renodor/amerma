# This will guess the User class
FactoryBot.define do
  factory :project do
    project_category

    sequence(:name) { |n| "project-#{n}" }
    sequence(:description) { |n| "project-#{n} cool description" }

    trait :with_cover_photo do
      after(:create) do |project_instance|
        project_instance.cover_photo.attach(
          io: File.open(Rails.root.join("spec", "fixtures", "images", "cover_photo.png")),
          filename: "cover_photo.png"
        )
      end
    end
  end
end
