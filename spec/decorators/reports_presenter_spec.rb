require "spec_helper"

describe ReportsPresenter do
  let(:user) { create(:user) }
  let(:provider) { TasksDecorator.new(Task.where(user_id: user.id)) }
  let!(:tasks) do
    5.times { create(:task, task_params(Time.current)) }
    2.times { create(:task, task_params(2.weeks.ago)) }
  end

  subject { described_class.new(provider) }

  describe "#provider" do
    it "spec_name" do
      expect(subject.provider).to be_an_instance_of TasksDecorator
    end
  end

  describe "#weekly_total" do
    it "gives the total task time for the current week" do
      expect(subject.weekly_total).to eq "13:53:20"
    end
  end

  describe "#time_remaining_for_week" do
    it "gives the time remaining for the week to reach 40 hours" do
      expect(subject.time_remaining_for_week).to eq "26:06:40"
    end
  end

  describe "#monthly_total" do
    it "gives the total task time for the current month" do
      expect(subject.monthly_total).to eq find_monthly_total_for_test
    end
  end

  def task_params(time)
    { user_id: user.id, duration: 10000, updated_at: time }
  end
end
