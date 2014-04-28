require "spec_helper"

feature "Deleting Projects" do
  let(:user) { create(:user) }
  let!(:project) { create(:project, user_id: user.id) }
  background do
    visit_projects_page
  end

  feature "Clicking the delete button" do
    scenario "deletes that project" do
      click_button "Delete"
      expect(page).not_to have_content project.name
    end
  end
end
