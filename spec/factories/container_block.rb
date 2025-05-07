FactoryBot.define do
  factory :container_block do
    association :containerable, factory: :project
    sequence(:position)
    column_count { 1 }
    class_list { ["grid", "gap-6", "items-center", "p-4", "border-none"] }
  end
end
