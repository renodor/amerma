FactoryBot.define do
  factory :content_block do
    association :container_block
    sequence(:position)
    class_list { %w[flex justify-center items-center] }

    trait :with_text_block do
      contentable { association(:text_block) }
    end

    trait :with_image_block do
      contentable { association(:image_block) }
    end
  end
end
