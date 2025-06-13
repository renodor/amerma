require "rails_helper"

RSpec.describe "Admin::ImageUpload" do
  let!(:project) { create(:project) }
  let!(:container_block) { create(:container_block, containerable: project) }
  let!(:content_block) { create(:content_block, :with_image_block, container_block: container_block) }

  before do
    login_as_user
    visit admin_project_path(project)
    # find("[data-spec='edit-image-block']", visible: false).click
  end

  it "doesn't display remove image button by default"

  it "uses default image variant"

  it "uses given image variant when specified"

  it "allows to upload an image"

  context "when there is no image" do
    it "doesn't display image preview"

    it "displays choose image text on button"
  end

  context "when an image is chosen" do
    it "displays image preview"

    it "displays change image text on button"
  end

  context "when remove image button is displays" do
    it "removes the image when remove button is clicked"

    it "disables the remove image input when a new image is uploaded"
  end
end
