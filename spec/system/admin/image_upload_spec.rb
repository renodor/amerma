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

  context "when there is no image yet" do
    it "test", :debug do
      debugger
    end
  end
end
