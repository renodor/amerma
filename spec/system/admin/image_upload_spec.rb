require "rails_helper"

RSpec.describe "Admin::ImageUpload" do
  let!(:project) { create(:project, :with_cover_photo) }
  let!(:container_block) { create(:container_block, containerable: project) }
  let!(:content_block) { create(:content_block, :with_image_block, container_block: container_block) }

  before { login_as_user }

  context "when there is an image" do
    it "displays the image preview" do
      visit admin_project_path(project)

      within("[data-spec='content-block-#{content_block.id}']") do
        find("[data-spec='edit-image-block']", visible: false).click
        expect(find("[data-spec='image-preview']")).to be_visible
        expect(find("[data-spec='image-preview']")["src"]).to match(content_block.contentable.image.filename.to_s)
      end
    end

    it "displays text to change image" do
      visit admin_project_path(project)

      within("[data-spec='content-block-#{content_block.id}']") do
        find("[data-spec='edit-image-block']", visible: false).click
        expect(page).to have_text(I18n.t("change_image"))
      end
    end

    it "uses default image variant as a preview" do
      visit admin_project_path(project)

      within("[data-spec='content-block-#{content_block.id}']") do
        find("[data-spec='edit-image-block']", visible: false).click
        expect(find("[data-spec='image-preview']").native.attribute("data-variant-name")).to eq("default")
      end
    end

    it "uses given image variant as a preview when specified" do
      visit edit_admin_project_path(project)

      expect(find("[data-spec='image-preview']").native.attribute("data-variant-name")).to eq("cover")
    end

    it "doesn't display remove image button by default" do
      visit admin_project_path(project)

      within("[data-spec='content-block-#{content_block.id}']") do
        find("[data-spec='edit-image-block']", visible: false).click
        sleep 0.3
        expect(page).not_to have_selector("[data-spec='remove-image-button']")
      end
    end

    it "displays remove image button when specified" do
      visit edit_admin_project_path(project)

      expect(page).to have_selector("[data-spec='remove-image-button']")
    end
  end

  context "when there is no image" do
    it "doesn't display image preview" do
      visit new_admin_team_member_path

      expect(page).not_to have_selector("[data-spec='image-preview']")
    end

    it "displays text to choose image" do
      visit new_admin_team_member_path

      expect(page).to have_text(I18n.t("choose_photo"))
    end

    it "doesn't display remove image button" do
      visit new_admin_project_path(project)

      expect(page).not_to have_selector("[data-spec='remove-image-button']")
    end
  end

  context "when an image is chosen" do
    before { visit new_admin_team_member_path }

    it "displays image preview" do
      expect(page).not_to have_selector("[data-spec='image-preview']")

      attach_file("team_member[photo]", Rails.root.join("spec", "fixtures", "images", "image.jpg"), visible: false)

      expect(find("[data-spec='image-preview']")).to be_visible
    end

    it "displays text to change image" do
      expect(page).to have_text(I18n.t("choose_photo"))

      attach_file("team_member[photo]", Rails.root.join("spec", "fixtures", "images", "image.jpg"), visible: false)

      expect(page).to have_text(I18n.t("change_photo"))
    end

    it "displays error message when image is not valid and hide it when image is valid again" do
      expect(page).not_to have_selector("[data-spec='image-invalid-message']")

      attach_file("team_member[photo]", Rails.root.join("spec", "fixtures", "sample.pdf"), visible: false)

      expect(find("[data-spec='image-invalid-message']")).to have_text(I18n.t("invalid_image_uploaded_message"))

      attach_file("team_member[photo]", Rails.root.join("spec", "fixtures", "images", "image.jpg"), visible: false)

      expect(page).not_to have_selector("[data-spec='image-invalid-message']")
    end
  end

  context "when remove button is clicked" do
    it "removes image preview and removes button" do
      visit edit_admin_project_path(project)

      expect(find("[data-spec='image-preview']")).to be_visible

      find("[data-spec='remove-image-button']").click

      expect(page).not_to have_selector("[data-spec='image-preview']")
      expect(page).not_to have_selector("[data-spec='remove-image-button']")
    end

    it "sends params so that image is removed from the record" do
      expect(project.reload.cover_photo).to be_attached

      visit edit_admin_project_path(project)
      find("[data-spec='remove-image-button']").click
      click_on I18n.t("save")
      find("[data-spec='flash']")

      expect(project.reload.cover_photo).not_to be_attached
    end

    it "disables the remove image input when a new image is uploaded" do
      visit edit_admin_project_path(project)

      expect(find("[data-spec='remove-image-input']", visible: false)).to be_disabled

      find("[data-spec='remove-image-button']").click

      expect(find("[data-spec='remove-image-input']", visible: false)).not_to be_disabled

      attach_file("project[cover_photo]", Rails.root.join("spec", "fixtures", "images", "cover_photo2.png"), visible: false)

      expect(find("[data-spec='remove-image-input']", visible: false)).to be_disabled
    end
  end
end
