require 'spec_helper'

describe Task do
  let(:user) { create(:user) }
  subject(:task) { build(:task, user_id: user.id) }

  it { should be_valid }

  describe "#duration" do
    it "returns the duration of the task" do
      set_times(342, 8372)
      expect(subject.duration).to eq 8030
    end
  end

  describe "#minutes" do
    it "returns the duration in minutes" do
      set_times(0, 300)
      expect(subject.minutes).to eq 5
    end
  end

  describe "#hours" do
    it "returns the duration in hours" do
      set_times(10000, 20000)
      expect(subject.hours).to eq 2
    end
  end

  def set_times(start, stop)
    task.start_time = start
    task.stop_time = stop
  end
end
