require 'open-uri'

project_cover_photos = [
  "https://images.unsplash.com/photo-1486718448742-163732cd1544",
  "https://images.unsplash.com/photo-1506806732259-39c2d0268443",
  "https://images.unsplash.com/photo-1516783154360-123b392d0833",
  "https://images.unsplash.com/photo-1621272036047-bb0f76bbc1ad",
  "https://images.unsplash.com/photo-1519389950473-47ba0277781c",
  "https://images.unsplash.com/photo-1523240795612-9a054b0db644",
  "https://images.unsplash.com/photo-1454165804606-c3d57bc86b40",
  "https://images.unsplash.com/photo-1528717384022-f8d665c86909",
  "https://images.unsplash.com/photo-1661370824378-e13ecc946815",
  "https://images.unsplash.com/photo-1486475554424-2fa50cd59f18",
  "https://images.unsplash.com/photo-1487017159836-4e23ece2e4cf",
  "https://images.unsplash.com/photo-1680745840784-318be3708374",
  "https://images.unsplash.com/photo-1496247749665-49cf5b1022e9",
  "https://images.unsplash.com/photo-1522322512347-a0e57fd1744c",
  "https://images.unsplash.com/photo-1488972685288-c3fd157d7c7a"
]

puts "Deleting all records..."
Project.delete_all
ProjectCategory.delete_all
Page.delete_all

puts "Creating project categories..."
categories = [
  {
      name: "Etudes",
      description: "Visant à développer les connaissances autour des nouvelles approches industrielles.",
      position: 1,
      icon: "book"
  },
  {
    name: "Accompagnement de la structuration de filières industrielles!",
    description: "Afin de produire localement et de façon durable des biens et services essentiels au territoire.",
    icon: "factory"
  },
  {
    name: "Low tech industries",
    description: "Projects related to low tech industries",
    icon: "windmill"
  }
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
      featured: true,
      visible: true
    )

    project.cover_photo.attach(io: URI.parse(project_cover_photos[(i * 5) + j]).open, filename: "#{project.name} - cover photo", content_type: "image/jpg")
    project.save!
    puts "Created project: #{project.name}"
  end
end

puts "Create pages and texts"
Page.create!(name: "home").container_blocks.create(location: "home").content_blocks.create!(contentable: TextBlock.new(text: "<div>Dans cette optique, AMERMA défend le concept de techno-discernement associé à la démarche low-tech, utilisée à des échelles industrielles, notamment à travers son application aux moyens de production des biens et services essentiels au fonctionnement de notre société.</div>"))

about = Page.create!(name: "about")
about.container_blocks.create(location: "about_1").content_blocks.create!(contentable: TextBlock.new(text: "<div><strong>Qui sommes nous texte 1</strong> lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam.</div>"))
about.container_blocks.create(location: "about_2").content_blocks.create!(contentable: TextBlock.new(text: "<div><strong>Qui sommes nous texte 2</strong> lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam. Sed quis lectus vel risus ornare pharetra. Etiam id condimentum purus. Phasellus condimentum, ipsum in sagittis ultrices, urna libero pretium tortor, non molestie tortor arcu ac ipsum. Ut ultricies justo sed elit volutpat aliquet. Proin eget ultrices ipsum. Nulla ullamcorper diam et arcu dapibus bibendum. Aliquam posuere convallis odio eu malesuada. Etiam luctus convallis purus et tempus.<br \><br \>Mauris et sapien molestie, venenatis risus at, hendrerit mi. Mauris congue quam eget libero ultricies, non scelerisque mauris iaculis. Nulla eu ornare augue. In id quam lobortis, porta massa at, auctor lectus. Suspendisse sed tincidunt ante. Aliquam sollicitudin sapien risus, in iaculis diam dapibus eu. Sed euismod dapibus enim non suscipit. Nulla sit amet vestibulum felis, sed pharetra arcu. Integer sollicitudin orci eget cursus consectetur. Pellentesque ut cursus mi, eget sodales nisl. Morbi bibendum mauris bibendum quam facilisis, non molestie massa molestie. Sed et sem convallis, pharetra justo laoreet, blandit elit.</div>"))
about.container_blocks.create(location: "about_3").content_blocks.create!(contentable: TextBlock.new(text: "<div><strong>Qui sommes nous texte 3</strong> lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam.</div>"))
about.container_blocks.create(location: "about_4").content_blocks.create!(contentable: TextBlock.new(text: "<div>Qui sommes nous texte 4 lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam. Sed quis lectus vel risus ornare pharetra. Etiam id condimentum purus. Phasellus condimentum, ipsum in sagittis ultrices, urna libero pretium tortor, non molestie tortor arcu ac ipsum. Ut ultricies justo sed elit volutpat aliquet. Proin eget ultrices ipsum. Nulla ullamcorper diam et arcu dapibus bibendum. Aliquam posuere convallis odio eu malesuada. Etiam luctus convallis purus et tempus.<br \><br \>Mauris et sapien molestie, venenatis risus at, hendrerit mi. Mauris congue quam eget libero ultricies, non scelerisque mauris iaculis. Nulla eu ornare augue. In id quam lobortis, porta massa at, auctor lectus. Suspendisse sed tincidunt ante. Aliquam sollicitudin sapien risus, in iaculis diam dapibus eu. Sed euismod dapibus enim non suscipit. Nulla sit amet vestibulum felis, sed pharetra arcu. Integer sollicitudin orci eget cursus consectetur. Pellentesque ut cursus mi, eget sodales nisl. Morbi bibendum mauris bibendum quam facilisis, non molestie massa molestie. Sed et sem convallis, pharetra justo laoreet, blandit elit.</div>"))

partners = Page.create!(name: "partners")
partners.container_blocks.create(location: "partners").content_blocks.create!(contentable: TextBlock.new(text: "<div><strong>Partners text</strong> lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam.</div>"))

contact = Page.create!(name: "contact")
contact.container_blocks.create(location: "contact").content_blocks.create!(contentable: TextBlock.new(text: "<div><strong>Contact text</strong> lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis augue ex. Fusce mollis libero vitae viverra mattis. Proin laoreet vehicula erat nec luctus. Aliquam malesuada ullamcorper aliquam.</div>"))


puts "Create team members"
3.times do |i|
  team_member = TeamMember.new(
    name: "Team member #{i + 1}",
    description: "Description for team member #{i + 1}"
  )

  team_member.photo.attach(io: URI.parse("https://picsum.photos/200").open, filename: "#{team_member.name} - profile", content_type: "image/jpg")
  team_member.save!
  puts "Created team member: #{team_member.name}"
end

puts "Create partners"
5.times do |i|
  partner = Partner.new(
    name: "Partner #{i + 1}",
    description: "Description for Partner #{i + 1}"
  )

  partner.logo.attach(io: URI.parse("https://picsum.photos/200").open, filename: "#{partner.name} - logo", content_type: "image/jpg")
  partner.save!
  puts "Created partner: #{partner.name}"
end

puts "Seeding completed."
