class PagesController < ApplicationController
  def home
    @home_text = Page.find_by(name: "home")&.container_blocks&.find_by(location: "home")&.content_blocks&.first&.text_block
    @project_categories = ProjectCategory.ordered
    @projects = Project.visible.featured.order(created_at: :desc).limit(3).includes(cover_photo_attachment: :blob)
  end

  def about
    @team_members = TeamMember.all.includes(photo_attachment: :blob)
    about_page = Page.find_by(name: "about")
    @about_text_1 = about_page&.container_blocks&.find_by(location: "about_1")&.content_blocks&.first&.text_block
    @about_text_2 = about_page&.container_blocks&.find_by(location: "about_2")&.content_blocks&.first&.text_block
    @about_text_3 = about_page&.container_blocks&.find_by(location: "about_3")&.content_blocks&.first&.text_block
    @about_text_4 = about_page&.container_blocks&.find_by(location: "about_4")&.content_blocks&.first&.text_block
  end
end
