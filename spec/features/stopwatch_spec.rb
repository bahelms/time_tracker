require "spec_helper"

feature "Stopwatch" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
  end

  feature "Clicking the start button" do
    context "without specifying a task" do
      scenario "counts upwards each second" do
        click_button "Start"
        pending
      end
    end
  end
end
