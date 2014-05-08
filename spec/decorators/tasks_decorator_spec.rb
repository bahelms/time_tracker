require "spec_helper"

describe TasksDecorator do
  subject { described_class }
  let(:decorator) { described_class.new(tasks) }
  let(:user) { create(:user) }
  let(:tasks) { Task.where(user_id: user.id) }

  before(:each) do
    4.times { create(:task, user_id: user.id) }
    2.times { create(:task, user_id: user.id, updated_at: 1.day.ago) }
    2.times { create(:task, user_id: user.id, updated_at: 2.weeks.ago) }
  end

  describe "#tasks" do
    it "gets all the tasks for the current week" do
      if monday?
        expect(decorator.tasks.count).to eq 4
      else
        expect(decorator.tasks.count).to eq 6
      end
    end

    it "decorates each task" do
      expect(decorator.tasks.first).to be_an_instance_of TaskDecorator
    end
  end

  describe "#grouped_by_day" do
    it "groups the tasks of the week by day" do
      tasks_by_day = decorator.grouped_by_day

      if monday?
        expect(tasks_by_day.last.map(&:id)).to eq Task.first(4).map(&:id)
      else
        expect(tasks_by_day.last.map(&:id)).to eq Task.all.to_a[4..5].map(&:id)
      end
    end
  end
end
