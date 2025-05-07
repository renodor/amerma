require "rails_helper"

RSpec.describe "Admin::Projects" do
  before { login_as_user }

  describe "#index" do
    let!(:project) { create(:project, :with_cover_photo) }
    let!(:project2) { create(:project) }

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
    let!(:project_category) { create(:project_category) }

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

    it "displays error message when project creation fails" do
      fill_in "#{I18n.t("name")} FR", with: "Mon Nouveau Projet FR"
      click_on I18n.t("save")
      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_create_error"))
    end
  end

  describe "#show", :debug do
    let!(:project_category) { create(:project_category, name: "Test Category Show") }
    let!(:project) do
      create(
        :project,
        :with_cover_photo,
        project_category: project_category,
        name: "Detailed Project FR",
        name_en: "Detailed Project EN",
        description: "FR Description for detailed view.",
        description_en: "EN Description for detailed view.",
        visible: true,
        featured: true,
        status: :completed,
        owner: "Project Owner Name",
        start_date: Date.today - 2.months,
        end_date: Date.today - 1.month
      )
    end
    let!(:container_block) { create(:container_block, containerable: project, position: 1) }
    let!(:content_block) { create(:content_block, container_block: container_block) }
    let!(:text_block) { content_block.contentable }

    before do
      text_block.update(text: "Sample Text FR", text_en: "Sample Text EN")
      visit admin_project_path(project)
    end

    it "displays page header and main actions" do
      expect(find("h1")).to have_text("#{I18n.t("edit")} #{project.name}")

      view_project_link = find_link(I18n.t("view_project"), href: project_path(project))
      expect(view_project_link).to be_visible
      expect(view_project_link[:target]).to eq("_blank")

      delete_form_selector = "form[action='#{admin_project_path(project)}'][method='post']"
      expect(page).to have_selector(delete_form_selector)
      within(delete_form_selector) do
        expect(page).to have_button(I18n.t("delete"))
        expect(page).to have_selector("input[name='_method'][value='delete']", visible: :hidden)
      end
    end

    it "displays project details within the turbo frame" do
      within_turbo_frame(dom_id(project)) do
        expect(page).to have_text(project_category.name)

        visibility_div_xpath = ".//div[contains(., '#{project.visible? ? I18n.t("visible") : I18n.t("hidden")}') and .//svg]"
        expect(find(:xpath, visibility_div_xpath)).to be_visible

        featured_div_xpath = ".//div[contains(., '#{project.featured? ? I18n.t("featured") : I18n.t("not_featured")}') and .//svg]"
        expect(find(:xpath, featured_div_xpath)).to be_visible

        # Assuming projects/_header partial displays these:
        expect(page).to have_selector("img[src*='cover_photo.png']")
        expect(page).to have_text(project.name)
        expect(page).to have_text(project.description)
        expect(page).to have_text(project.owner)
        expect(page).to have_text(I18n.t("activerecord.attributes.project.statuses.#{project.status}"))
        expect(page).to have_text(I18n.l(project.start_date, format: :long)) if project.start_date # Assuming long format
        expect(page).to have_text(I18n.l(project.end_date, format: :long)) if project.end_date # Assuming long format

        expect(page).to have_link(I18n.t("edit"), href: edit_admin_project_path(project))
      end
    end

    it "displays container blocks and their actions" do
      within("div##{dom_id(project, :container_blocks)}") do
        within("section##{dom_id(container_block)}") do
          within("div##{dom_id(container_block, :content_blocks)}") do
            expect(page).to have_text("Sample Text FR") # Assuming FR locale for display
          end

          expect(page).to have_link(href: update_position_admin_project_container_block_path(project, container_block, direction: "down"))
          expect(page).to have_link(href: update_position_admin_project_container_block_path(project, container_block, direction: "up"))

          expect(find_button(I18n.t("edit"))).to be_visible # Edit button for this container_block

          delete_container_form_selector = "form[action='#{admin_project_container_block_path(project, container_block)}'][method='post']"
          expect(page).to have_selector(delete_container_form_selector)
          within(delete_container_form_selector) do
            expect(page).to have_button(I18n.t("delete"))
            expect(page).to have_selector("input[name='_method'][value='delete']", visible: :hidden)
          end
        end
      end
    end

    it "displays 'Add Container' button and modal" do
      add_container_button = find_button(I18n.t("container"))
      expect(add_container_button).to be_visible
      expect(add_container_button).to have_selector("svg") # Check for plus icon

      add_container_button.click

      within("dialog[data-modal-target='dialog']") do # Assumes dialog becomes [open] or is findable
        expect(page).to have_css("h3", text: I18n.t("new_container"))
        expect(page).to have_selector("form[action='#{admin_project_container_blocks_path(project)}'][method='post']")
        expect(page).to have_field("container_block[column_count]")
        expect(page).to have_button(I18n.t("save"))
      end
    end
  end
end
