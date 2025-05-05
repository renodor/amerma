require "rails_helper"

RSpec.describe "Admin::Projects", :debug do
  let!(:project) { create(:project, :with_cover_photo) }
  let!(:project2) { create(:project) }
  let!(:project_category) { create(:project_category) }

  before { login_as_user }

  describe "#index" do
    before { visit admin_projects_path }

    it "displays page header" do
      expect(find("header")).to have_selector("h1", text: I18n.t("projects"))
      expect(find("header")).to have_link(I18n.t("new_project"), href: new_admin_project_path)
    end

    it "displays projects" do
      within("[data-spec='project-#{project.id}']") do
        cover_photo = find("img[src*='cover_photo.png']")
        expect(cover_photo).to be_visible
        expect(page.evaluate_script("arguments[0].width", cover_photo)).to eq 96
        expect(page.evaluate_script("arguments[0].height", cover_photo)).to eq 96
        expect(find("[data-spec='project-name']")).to have_text(project.name)
        expect(find("[data-spec='project-description']")).to have_text(project.description)
        expect(page).to have_link(I18n.t("edit"), href: admin_project_path(project))

        delete_form = find("[data-spec='delete-project']")
        expect(delete_form).to have_button(I18n.t("delete"))
        expect(delete_form[:action]).to match(/#{admin_project_path(project)}/)
        expect(delete_form[:method]).to eq("post")
        expect(delete_form).to have_selector("input[name='_method'][value='delete']", visible: :hidden)
      end

      within("[data-spec='project-#{project2.id}']") do
        expect(page).not_to have_selector("img")
        expect(find("[data-spec='project-name']")).to have_text(project2.name)
        expect(find("[data-spec='project-description']")).to have_text(project2.description)
      end
    end
  end

  describe "#new and #create" do
    before { visit new_admin_project_path }

    it "creates a new project" do
      project_name_fr = "Mon Nouveau Projet FR"
      project_name_en = "My New Project EN"
      project_desc_fr = "Description française détaillée."
      project_desc_en = "Detailed English description."
      project_owner = "Amerma"
      start_date = Date.today
      end_date = Date.today + 1.month
      cover_photo_path = Rails.root.join("spec/fixtures/images/cover_photo.png")

      select project_category.name, from: "project[project_category_id]"
      find("label", text: I18n.t("visible")).click
      find("label", text: I18n.t("featured")).click
      attach_file("project[cover_photo]", cover_photo_path, visible: false)
      fill_in "#{I18n.t("name")} FR", with: project_name_fr
      fill_in "#{I18n.t("name")} EN", with: project_name_en
      find("label", text: I18n.t("in_progress")).click
      fill_in I18n.t("start_date"), with: start_date
      fill_in I18n.t("end_date"), with: end_date
      fill_in I18n.t("owner"), with: project_owner
      fill_in "#{I18n.t("description")} FR", with: project_desc_fr
      fill_in "#{I18n.t("description")} EN", with: project_desc_en

      click_on I18n.t("save")
      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_created"))

      project = Project.find_by(name: project_name_fr)
      expect(page).to have_current_path(admin_project_path(project))
      expect(project.project_category).to eq(project_category)
      expect(project).to be_visible
      expect(project).to be_featured
      expect(project.cover_photo).to be_attached
      expect(project.name).to eq(project_name_fr)
      expect(project.name_en).to eq(project_name_en)
      expect(project.status).to eq("in_progress")
      expect(project.start_date).to eq(start_date)
      expect(project.end_date).to eq(end_date)
      expect(project.owner).to eq(project_owner)
      expect(project.description).to eq(project_desc_fr)
      expect(project.description_en).to eq(project_desc_en)
    end
  end
end
