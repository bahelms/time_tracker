require "spec_helper"

feature "Creating a new project" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
    click_link "Projects"
    fill_in "Name", with: "Test Project Feature"
  end

  scenario "creates a new project" do
    expect { clink_button "Create" }.to change(Project, :count).by(1)
  end
end
