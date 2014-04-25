def create_projects
  5.times { create(:project) }
end

def enter_name(name)
  fill_in "project[name]", with: name
end
