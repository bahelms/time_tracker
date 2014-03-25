require "spec_helper"

feature "Stopwatch" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
  end

  context "when the Start button is clicked" do
    scenario "counts upwards each second" do
      click_button "Start"
      pending
    end
  end
end
