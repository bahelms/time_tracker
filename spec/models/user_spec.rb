require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  it { should be_valid }

  context "without a username" do
    it "is invalid" do
      user.username = nil
      expect(user).not_to be_valid
    end
  end
end
