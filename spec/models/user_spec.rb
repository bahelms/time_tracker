require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }

  it { should be_valid }
end
