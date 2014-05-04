require "spec_helper"

feature "Viewing all projects" do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "hello@world.com") }
  subject { page }

  background do
    create_projects(user)
    create_projects(user2)
    visit root_path
    sign_in_with(email: user.email, password: user.password)
    click_link "Projects"
  end

  scenario "displays all projects for user" do
    names = Project.where(user_id: user.id).map(&:name)
    content = names.map { |name| page.has_content? name }
    expect(content.include? false).to eq false
  end

  scenario "does not display projects for other users" do
    names = Project.where(user_id: user2.id).map(&:name)
    content = names.map { |name| page.has_content? name }
    expect(content.uniq.first).to eq false
  end
end
