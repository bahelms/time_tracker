require "spec_helper"

feature "Signing up for a new account" do
  let(:old_user) { create(:user) }
  subject { page }

  background do
    visit root_path
    click_link "Sign Up"
  end

  it { should have_content("Create Account") }
  it { should have_content("Email") }
  it { should have_content("Username") }
  it { should have_content("Password") }
  it { should have_content("Password confirmation") }

  context "with valid input" do
    scenario "creates a new account if email and password are valid" do
      signup_with email: "heybob@foobar.com", password: "@123abc!"
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end

  context "with invalid input" do
    scenario "notifies user if the email is absent" do
      signup_with email: nil, password: "@123abc!"
      expect(page).to have_content("Email can't be blank")
    end

    scenario "notifies user if the email has been used already" do
      signup_with email: old_user.email, password: "@123abc!"
      expect(page).to have_content("Email has already been taken")
    end

    scenario "notifies user if the password is absent" do
      signup_with email: "what@hey.com", password: nil
      expect(page).to have_content("Password can't be blank")
    end

    scenario "notifies user if the password confirmation doesn't match" do
      signup_with email: "what@bar.com", password: "@123abc!", confirm: "12341234"
      expect(page).to have_content("Password confirmation doesn't match")
    end
  end
end
