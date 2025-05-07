FactoryBot.define do
  factory :content_block do
    association :container_block
    contentable { association(:text_block) }
    sequence(:position)
  end
end
