require "spec_helper"

feature "Recording time for a task" do
  let!(:user) { create(:user) }
  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
  end

  context "without specifying a task" do
    scenario "counts upwards each second" do
      expect { click_button "Start" }.not_to change(Task, :count)
    end
  end

  context "when the task is new" do
    background do
      binding.pry
      fill_in "task_field", with: "TestTask1"
    end

    scenario "creates a task" do
      binding.pry
      expect { click_button "Start" }.to change(Task, :count).by(1)
    end
  end
end
