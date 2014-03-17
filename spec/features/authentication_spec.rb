require "spec_helper"

feature "Signing up for a new account" do
  scenario "creates a new account if email and password are valid" do
  end

  scenario "notifies user it the email is invalid" do
    visit root_path
    click_link "Sign Up"
    expect(page).to have_content("Create Account")
  end
end

feature "Signing in with an existing account" do
  scenario "successfully signs in user if email and password are valid" do
  end

  scenario "notifies user if the email is invalid" do
    visit root_path
    fill_in "Email", with: "invalid_email"
    click_button "Sign In"
    expect(page).to have_content("Sign In")
  end
end
