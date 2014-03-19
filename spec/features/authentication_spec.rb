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

feature "Signing in with an existing account" do
  let(:user) { create(:user) }
  subject { page }
  background { visit root_path }

  it { should have_content("Sign In") }
  it { should have_content("Email") }
  it { should have_content("Password") }

  context "with valid input" do
    scenario "successfully signs in user if email and password are valid" do
      sign_in_with email: user.email, password: user.password
      expect(page).to have_content("Signed in successfully.")
    end

    feature "Signing out of a valid session" do
      background do
        sign_in_with email: user.email, password: user.password
        click_link "Sign Out"
      end

      it { should_not have_link "Sign Out" }
      it { should have_button "Sign In" }
    end
  end

  context "with invalid email or password" do
    scenario "notifies user if the email is invalid" do
      sign_in_with email: nil, password: user.password
      expect(page).to have_content("Invalid email or password")
    end

    scenario "notifies user if the password is invalid" do
      sign_in_with email: user.email, password: "waht_me_worry?"
      expect(page).to have_content("Invalid email or password")
    end
  end
end
