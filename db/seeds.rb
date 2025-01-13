# db/seeds.rb

puts "Deleting all records..."
Project.delete_all
ProjectCategory.delete_all

puts "Creating project categories..."
categories = [
  { name: "Market studies", description: "Projects related to market studies" },
  { name: "Industry Support", description: "Projects related to industry support" },
  { name: "Low tech industries", description: "Projects related to low tech industries" }
]

categories.each do |category_attrs|
  category = ProjectCategory.create!(category_attrs)
  puts "Created project category: #{category.name}"

  5.times do |i|
    project_attrs = {
      name: "Project #{i + 1} - #{category.name}",
      description: "Description for project #{i + 1} in #{category.name}",
      status: ["planned", "in_progress", "completed"].sample,
      start_date: Date.today - rand(100).days,
      end_date: Date.today + rand(100).days,
      featured: [true, false].sample
    }
    project = category.projects.create!(project_attrs)
    puts "  Created project: #{project.name}, Featured: #{project.featured}"
  end
end

puts "Seeding completed."
