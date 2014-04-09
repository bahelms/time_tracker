require "spec_helper"

describe DashboardController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #show" do
    before(:each) do
      4.times { create(:task, user_id: user.id) }
      2.times { create(:task, user_id: user.id, updated_at: 1.day.ago) }
      2.times { create(:task, user_id: user.id, updated_at: 2.weeks.ago) }
      get :show
    end

    it "gets all the tasks for the current week" do
      expect(assigns(:tasks).tasks.flatten.count).to eq 6
    end

    it "groups the tasks of the week by day" do
      tasks_by_day = assigns(:tasks).grouped_by_day
      expect(tasks_by_day.first.map(&:id)).to eq Task.first(4).map(&:id)
      expect(tasks_by_day.last.map(&:id)).to eq Task.all.to_a[4..5].map(&:id)
    end
  end
end
