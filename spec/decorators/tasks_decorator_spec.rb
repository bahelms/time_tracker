require "spec_helper"

describe TasksDecorator do
  it "does stuff" do
    pending "Test decorator"
  end
  # before(:each) do
  #   4.times { create(:task, user_id: user.id) }
  #   2.times { create(:task, user_id: user.id, updated_at: 1.day.ago) }
  #   2.times { create(:task, user_id: user.id, updated_at: 2.weeks.ago) }
  #   get :show
  # end

  # it "gets all the tasks for the current week" do
  #   if monday?
  #     expect(assigns(:tasks).tasks.flatten.count).to eq 4
  #   else
  #     expect(assigns(:tasks).tasks.flatten.count).to eq 6
  #   end
  # end

  # it "groups the tasks of the week by day" do
  #   tasks_by_day = assigns(:tasks).grouped_by_day
  #   expect(tasks_by_day.first.map(&:id)).to eq Task.first(4).map(&:id)

  #   if monday?
  #     expect(tasks_by_day.last.map(&:id)).to eq Task.first(4).map(&:id)
  #   else
  #     expect(tasks_by_day.last.map(&:id)).to eq Task.all.to_a[4..5].map(&:id)
  #   end
  # end
end
