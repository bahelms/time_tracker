require "spec_helper"

feature "Viewing all projects" do
  let!(:user) { create(:user) }
  let!(:projects) { 5.times { create(:project) } }
  subject { page }

  background do
    visit root_path
    sign_in_with(email: user.email, password: user.password)
    click_link "Projects"
  end

  it "displays all projects for user" do
    projects.each do |project|
      it { should have_contect project.name }
    end
  end
end
