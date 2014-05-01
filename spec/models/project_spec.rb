require "spec_helper"

describe Project do
  let(:user) { create(:user) }
  subject { build(:project, user_id: user.id) }

  it { should be_valid }
end
