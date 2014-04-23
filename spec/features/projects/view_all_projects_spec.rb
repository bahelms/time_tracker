require "spec_helper"

feature "Viewing all projects" do
  let!(:user) { create(:user) }
  subject { page }

  background do
    create_projects
    visit root_path
    sign_in_with(email: user.email, password: user.password)
    click_link "Projects"
  end

  it "displays all projects for user" do
    Project.all.each do |project|
      expect(subject).to have_content project.name
    end
  end
end
