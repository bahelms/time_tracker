require "spec_helper"

feature "Creating a new project" do
  let!(:user) { create(:user) }
  let(:project_name) { "Test Project Feature" }
  background do
    visit_projects_page
  end

  context "without a name" do
    scenario "does not create a project" do
      expect { click_button "Create New Project" }.to raise_exception
    end
  end

  context "with a name" do
    background { enter_name project_name }

    scenario "creates a new project" do
      expect { click_button "Create New Project" }.to change(Project, :count).by(1)
    end

    scenario "displays the project on the page" do
      click_button "Create New Project"
      expect(page).to have_content "Project: #{project_name}"
    end
  end
end
