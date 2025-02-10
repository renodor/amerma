class PagesController < ApplicationController
  def home
    container_blocks = Page.find_by(name: "home").container_blocks
    @home_text_1 = container_blocks&.find_by(location: "home_1")&.content_blocks&.first&.text_block
    @home_text_2 = container_blocks&.find_by(location: "home_2")&.content_blocks&.first&.text_block
    @project_categories = ProjectCategory.ordered
    @projects = Project.visible.featured.order(created_at: :desc).limit(3).includes(cover_photo_attachment: :blob)
  end

  def about
    @team_members = TeamMember.all.includes(photo_attachment: :blob)
    container_blocks = Page.find_by(name: "about").container_blocks
    # TODO: avoid N+1 here?
    @about_text_1 = container_blocks&.find_by(location: "about_1")&.content_blocks&.first&.text_block
    @about_text_2 = container_blocks&.find_by(location: "about_2")&.content_blocks&.first&.text_block
    @about_text_3 = container_blocks&.find_by(location: "about_3")&.content_blocks&.first&.text_block
    @about_text_4 = container_blocks&.find_by(location: "about_4")&.content_blocks&.first&.text_block
  end
end
