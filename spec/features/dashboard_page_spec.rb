require "spec_helper"

describe "Dashboard page" do
  before { visit root_path }
  subject { page }

  it { should have_content("Time Tracker") }
  it { should have_title("Time Tracker") }
end
