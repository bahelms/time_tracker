require "spec_helper"

feature "Signing up for a new account" do
  subject { page }

  background do
    visit root_path
    click_link "Sign Up"
  end

  scenario "visiting signup page" do
    expect(page).to have_content("Create Account")
    expect(page).to have_content("Email")
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
  end

  scenario "creates a new account if email and password are valid" do
    signup_with("heybob@foobar.com", "@123abc!")
    expect(page).to have_content("hdhd")
  end

  scenario "notifies user if the email is invalid" do
  end
end

feature "Signing in with an existing account" do
  subject { page }

  background do
    visit root_path
  end

  it { should have_content("Sign In") }
  it { should have_content("Email") }
  it { should have_content("Password") }

  scenario "successfully signs in user if email and password are valid" do
  end

  scenario "notifies user if the email is invalid" do
    fill_in "Email", with: "invalid_email"
    click_button "Sign In"
    expect(page).to have_content("Invalid email or password")
  end
end

def signup_with(email, password)
  fill_in "Username", with: "Bob"
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign Up"
end
