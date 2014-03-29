require 'spec_helper'

describe Task do
  let(:user) { create(:user) }
  subject(:task) { build(:task, user_id: user.id) }

  it { should be_valid }
end
