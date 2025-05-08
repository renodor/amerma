FactoryBot.define do
  factory :image_block do
    title { "Image title FR" }
    subtitle { "Image subtitle FR" }
    caption { "Image caption FR" }
    title_en { " Image title EN" }
    subtitle_en { "Image subtitle EN" }
    caption_en { " Image caption EN" }

    after(:build) do |image_block_instance|
      image_block_instance.image.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "images", "image.jpg")),
        filename: "image.jpg"
      )
    end
  end
end
