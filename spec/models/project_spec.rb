require "spec_helper"

describe Project do
  subject { build(:project) }

  it { should be_valid }
end
