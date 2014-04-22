require "spec_helper"

describe Project do
  subject { build(:project, name: "Test Project") }

  it { should be_valid }
end
