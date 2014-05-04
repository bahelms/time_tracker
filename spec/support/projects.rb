def create_projects(user)
  5.times { create(:project, user_id: user.id) }
end

def enter_name(name)
  fill_in "project[name]", with: name
end

def visit_projects_page
  visit root_path
  sign_in_with(email: user.email, password: user.password)
  click_link "Projects"
end
