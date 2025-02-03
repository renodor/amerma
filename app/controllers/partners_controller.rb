class PartnersController < ApplicationController
  def index
    @partners = Partner.all
    @partners_text = Page.find_by(name: "partners")&.container_blocks&.find_by(location: "partners")&.content_blocks&.first&.text_block
  end
end
