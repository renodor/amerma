require "rails_helper"

RSpec.describe "Admin::Projects" do
  let(:project_category) { create(:project_category, name: "Project category", icon: "windmill") }
  let!(:project_category2) { create(:project_category, name: "Project Category 2") }
  let!(:project) do
    create(
      :project,
      :with_cover_photo,
      project_category: project_category,
      name: "Project FR",
      name_en: "Project EN",
      description: "Project Description FR",
      description_en: "Project Description EN",
      visible: true,
      featured: true,
      status: :completed,
      owner: "Project Owner Name",
      start_date: Date.today - 2.months,
      end_date: Date.today - 1.month
    )
  end

  before { login_as_user }

  describe "#index" do
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
        expect(page).to have_link(I18n.t("manage"), href: admin_project_path(project))

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

      expect(page).to have_current_path(new_admin_project_path)
      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_create_error"))
    end
  end

  describe "#show" do
    let!(:container_block) { create(:container_block, containerable: project, position: 1, column_count: 2) }
    let!(:content_block) { create(:content_block, container_block: container_block, contentable: create(:text_block)) }
    let!(:content_block2) { create(:content_block, container_block: container_block, contentable: create(:image_block)) }

    before { visit admin_project_path(project) }

    it "displays page header and actions" do
      expect(find("h2")).to have_text(project.name)

      view_project_link = find("[data-spec='project-link']")
      expect(view_project_link).to be_visible
      expect(view_project_link).to have_text(I18n.t("view_project"))
      expect(view_project_link[:href]).to match(/projects\/#{project.id}/)
      expect(view_project_link[:target]).to eq("_blank")

      delete_button = find("[data-spec='delete-project']")
      expect(delete_button).to be_visible
      expect(delete_button).to have_text(I18n.t("delete"))

      accept_confirm { delete_button.click }

      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_deleted"))
      expect(page).to have_current_path(admin_projects_path)
      expect(Project.exists?(project.id)).to be false
    end

    it "displays project details" do
      within("[data-spec='project-#{project.id}']") do
        expect(find("[data-spec='project-category']")).to have_text(project_category.name)
        expect(find("[data-spec='project-visibility']")).to have_text(I18n.t("visible"))
        expect(find("[data-spec='project-featured']")).to have_text(I18n.t("featured"))
        expect(find("header")).to have_selector("img[src*='cover_photo.png']")
        expect(find("header [data-spec='project-name']")).to have_text(project.name)
        expect(find("header [data-spec='project-category-icon']")[:id]).to eq("windmill")
        expect(find("header [data-spec='project-status']")).to have_text(I18n.t(project.status))
        expect(find("header [data-spec='project-dates']"))
          .to have_text("#{I18n.l(project.start_date, format: :default)} - #{I18n.l(project.end_date, format: :default)}")
        expect(find("header [data-spec='project-description']")).to have_text(project.description)
        expect(find("header [data-spec='project-owner']")).to have_text(project.owner)
        expect(page).to have_link(I18n.t("edit"), href: edit_admin_project_path(project))
      end
    end

    it "displays container blocks and their content blocks" do
      within("[data-spec='container-block-#{container_block.id}']") do
        expect(find("[data-spec='content-blocks']"))
          .to match_css(".grid.gap-6.items-center.p-4.border-none.grid-cols-1.sm\\:grid-cols-2")

        within("[data-spec='content-block-#{content_block.id}']") do
          expect(page).to have_text("Text FR")
          expect(find("b")).to have_text("FR")
        end

        within("[data-spec='content-block-#{content_block2.id}']") do
          expect(find("[data-spec='image-title']")).to have_text("Image title FR")
          expect(find("[data-spec='image-subtitle']")).to have_text("Image subtitle FR")
          expect(page).to have_selector("img[src*='image.jpg']")
          expect(find("[data-spec='image-caption']")).to have_text("Image caption FR")
        end
      end
    end
  end

  describe "#edit and #update" do
    before do
      visit admin_project_path(project)
      click_link I18n.t("edit"), href: edit_admin_project_path(project)
    end

    it "allows to update project" do
      new_name_fr = "Updated Project FR"
      new_name_en = "Updated Project EN"
      new_desc_fr = "Updated Description FR"
      new_desc_en = "Updated Description EN"
      new_owner = "Updated Owner"
      new_start_date = Date.today - 1.month
      new_end_date = Date.today + 2.months
      new_cover_photo_path = Rails.root.join("spec/fixtures/images/cover_photo2.png")

      select project_category2.name, from: "project[project_category_id]"
      find("label", text: I18n.t("hidden")).click
      find("label", text: I18n.t("not_featured")).click
      attach_file("project[cover_photo]", new_cover_photo_path, visible: false)
      fill_in "#{I18n.t("name")} FR", with: new_name_fr
      fill_in "#{I18n.t("name")} EN", with: new_name_en
      find("label", text: I18n.t("planned")).click
      fill_in I18n.t("start_date"), with: new_start_date
      fill_in I18n.t("end_date"), with: new_end_date
      fill_in I18n.t("owner"), with: new_owner
      fill_in "#{I18n.t("description")} FR", with: new_desc_fr
      fill_in "#{I18n.t("description")} EN", with: new_desc_en

      click_on I18n.t("save")

      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_updated"))

      project.reload
      expect(project.project_category).to eq(project_category2)
      expect(project).not_to be_visible
      expect(project).not_to be_featured
      expect(project.cover_photo).to be_attached
      expect(project.cover_photo.filename.to_s).to eq("cover_photo2.png")
      expect(project.name).to eq(new_name_fr)
      expect(project.name_en).to eq(new_name_en)
      expect(project.status).to eq("planned")
      expect(project.start_date).to eq(new_start_date)
      expect(project.end_date).to eq(new_end_date)
      expect(project.owner).to eq(new_owner)
      expect(project.description).to eq(new_desc_fr)
      expect(project.description_en).to eq(new_desc_en)
    end

    it "allows to remove project cover photo" do
      find("[data-spec='remove-cover-photo']").click
      click_on I18n.t("save")

      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_updated"))
      expect(project.reload.cover_photo).not_to be_attached
    end

    it "displays error message when project update fails" do
      attach_file("project[cover_photo]", Rails.root.join("spec/fixtures/sample.pdf"), visible: false)
      click_on I18n.t("save")

      expect(page).to have_current_path(edit_admin_project_path(project))
      expect(find("[data-spec='flash']")).to have_text(I18n.t("project_update_error"))
    end
  end

  describe "Project content builder" do
    before { visit admin_project_path(project) }

    it "allows to add container blocks to project and displays it correctly" do
      # Container block with default values: 1 column, items centered, no border
      click_on I18n.t("container")
      click_on I18n.t("save")

      expect(find("[data-spec='flash']")).to have_text(I18n.t("container_block_created"))
      expect(project.reload.container_blocks.count).to eq(1)

      container_block = project.container_blocks.last
      expect(container_block.position).to eq(1)
      expect(container_block.column_count).to eq(1)
      expect(container_block.content_blocks.count).to eq(1)
      expect(container_block.class_list).to contain_exactly("grid", "gap-6", "p-4", "items-center", "border-none")

      content_block = container_block.content_blocks.first
      expect(content_block.position).to eq(1)
      expect(content_block.class_list).to contain_exactly("flex", "justify-center", "items-center")

      within("[data-spec='container-block-#{container_block.id}']") do
        expect(find("[data-spec='content-blocks']"))
          .to match_css(".grid.gap-6.items-center.p-4.border-none.grid-cols-1")

        expect(all("[data-spec^='content-block-']").count).to eq(1)

        expect(page).to have_selector("[data-spec='content-block-#{container_block.content_blocks.first.id}']")
      end

      find("[data-spec='flash'] [data-spec='remove-flash']").click

      # Container block with 2 columns, items top, and dashed border
      click_on I18n.t("container")
      find("label", text: I18n.t("two_columns")).click
      find("label", text: I18n.t("items_top")).click
      find("label", text: I18n.t("dashed_border")).click
      click_on I18n.t("save")

      expect(find("[data-spec='flash']")).to have_text(I18n.t("container_block_created"))
      expect(project.reload.container_blocks.count).to eq(2)

      container_block = project.container_blocks.last
      expect(container_block.position).to eq(2)
      expect(container_block.column_count).to eq(2)
      expect(container_block.content_blocks.count).to eq(2)
      expect(container_block.class_list)
        .to contain_exactly("grid", "gap-6", "p-4", "items-start", "dashed-border")

      container_block.content_blocks.each_with_index do |content_block, index|
        expect(content_block.position).to eq(index + 1)
        expect(content_block.class_list).to contain_exactly("flex", "justify-center", "items-center")
      end

      within("[data-spec='container-block-#{container_block.id}']") do
        expect(find("[data-spec='content-blocks']"))
          .to match_css(".grid.gap-6.items-start.p-4.dashed-border.grid-cols-1.sm\\:grid-cols-2")

        expect(all("[data-spec^='content-block-']").count).to eq(2)

        container_block.content_blocks.each do |content_block|
          expect(page).to have_selector("[data-spec='content-block-#{content_block.id}']")
        end
      end

      find("[data-spec='flash'] [data-spec='remove-flash']").click

      # Container block with 4 columns, shadow border
      click_on I18n.t("container")
      find("label", text: I18n.t("four_columns")).click
      find("label", text: I18n.t("centered_items")).click
      find("label", text: I18n.t("shadow_border")).click
      click_on I18n.t("save")

      expect(find("[data-spec='flash']")).to have_text(I18n.t("container_block_created"))
      expect(project.reload.container_blocks.count).to eq(3)

      container_block = project.container_blocks.last
      expect(container_block.position).to eq(3)
      expect(container_block.column_count).to eq(4)
      expect(container_block.content_blocks.count).to eq(4)
      expect(container_block.class_list)
        .to contain_exactly("grid", "gap-6", "p-4", "items-center", "shadow-border")

      container_block.content_blocks.each_with_index do |content_block, index|
        expect(content_block.position).to eq(index + 1)
        expect(content_block.class_list).to contain_exactly("flex", "justify-center", "items-center")
      end

      within("[data-spec='container-block-#{container_block.id}']") do
        expect(find("[data-spec='content-blocks']"))
          .to match_css(".grid.gap-6.items-center.p-4.shadow-border.grid-cols-1.sm\\:grid-cols-2.md\\:grid-cols-3.lg\\:grid-cols-4")

        expect(all("[data-spec^='content-block-']").count).to eq(4)

        container_block.content_blocks.each do |content_block|
          expect(page).to have_selector("[data-spec='content-block-#{content_block.id}']")
        end
      end
    end

    it "allow to edit container blocks"

    it "allows to remove container blocks"

    it "displays container blocks in order and allows to reorder them"

    it "allows to add, edit and remove content blocks"

    it "displays content blocks in order and allows to reorder them"

    context "container block form"

    context "content block form"
  end
end
