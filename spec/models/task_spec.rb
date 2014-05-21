require 'spec_helper'

describe Task do
  let(:user) { create(:user) }
  subject(:task) { build(:task, user_id: user.id) }

  it { should be_valid }

  describe "#minutes" do
    it "returns the duration in minutes" do
      subject.duration = 300
      expect(subject.minutes).to eq 5
    end
  end

  describe "#hours" do
    it "returns the duration in hours" do
      subject.duration = 10000
      expect(subject.hours).to eq 2
    end
  end
end
