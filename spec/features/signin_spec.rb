require "spec_helper"

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
