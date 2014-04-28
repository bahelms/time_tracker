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

  scenario "displays all projects for user" do
    names = Project.where(user_id: user.id).map(&:name)
    content = names.map { |name| page.has_content? name }
    expect(content.include? false).to eq false
  end
end
