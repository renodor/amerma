require 'open-uri'

project_cover_photos = [
  "https://images.unsplash.com/photo-1486718448742-163732cd1544",
  "https://images.unsplash.com/photo-1506806732259-39c2d0268443",
  "https://images.unsplash.com/photo-1516783154360-123b392d0833",
  "https://plus.unsplash.com/premium_photo-1661761077411-d50cba031848",
  "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
  "https://images.unsplash.com/photo-1523240795612-9a054b0db644",
  "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40",
  "https://plus.unsplash.com/premium_photo-1661963861529-02951a02a25f",
  "https://images.unsplash.com/photo-1661370824378-e13ecc946815",
  "https://images.unsplash.com/photo-1486475554424-2fa50cd59f18",
  "https://images.unsplash.com/photo-1487017159836-4e23ece2e4cf",
  "https://images.unsplash.com/photo-1680745840784-318be3708374",
  "https://images.unsplash.com/photo-1496247749665-49cf5b1022e9",
  "https://images.unsplash.com/photo-1522322512347-a0e57fd1744c",
  "https://plus.unsplash.com/premium_photo-1677640957827-e35fdcfdc889"
]

puts "Deleting all records..."
Project.delete_all
ProjectCategory.delete_all

puts "Creating project categories..."
categories = [
  { name: "Market studies", description: "Projects related to market studies" },
  { name: "Industry Support", description: "Projects related to industry support" },
  { name: "Low tech industries", description: "Projects related to low tech industries" }
]

categories.each_with_index do |category_attrs, i|
  category = ProjectCategory.create!(category_attrs)
  puts "Created project category: #{category.name}"

  5.times do |j|
    project = category.projects.new(
      name: "Project #{j + 1} - #{category.name}",
      description: "Description for project #{j + 1} in #{category.name}",
      status: ["planned", "in_progress", "completed"].sample,
      start_date: Date.today - rand(100).days,
      end_date: Date.today + rand(100).days,
      featured: [true, false].sample,
    )

    project.cover_photo.attach(io: URI.parse(project_cover_photos[(i * 5) + j]).open, filename: "#{project.name} - cover photo", content_type: "image/jpg")
    project.save!
    puts "Created project: #{project.name}"
  end
end

puts "Seeding completed."
