require "spec_helper"

feature "Creating a new project" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
  end

  scenario "" do
  end
end
