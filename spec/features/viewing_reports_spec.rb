require "spec_helper"

feature "Viewing reports" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
  end

  feature "clicking on the reports link from the dashboard" do
    background do
      click_link "Reports"
    end

    scenario "shows all the task details" do
      expect(page).to have_content "Total time for week:"
    end
  end
end
