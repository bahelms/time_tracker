require "spec_helper"

describe ReportsPresenter do
  let(:provider) { TasksDecoratorMock.new }
  subject { described_class.new(provider) }
  # let(:user) { create(:user) }
  # let(:tasks) { Task.where(user_id: user.id) }

  # describe "#provider" do
  #   it "spec_name" do
  #   end
  # end

  describe "#weekly_total" do
    it "gives the total task time for the current week" do
      expect(subject.weekly_total)
    end
  end

  describe "#time_remaining_for_week" do
    it "" do
      pending
    end
  end

  describe "#monthly_total" do
    it "" do
      pending
    end
  end
end
