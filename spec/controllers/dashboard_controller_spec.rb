require "spec_helper"

describe DashboardController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #show" do
    before(:each) do
      4.times { create(:task, user_id: user.id) }
      2.times { create(:task, user_id: user.id, updated_at: 2.weeks.ago) }
    end

    it "gets all the tasks for the current week" do
      get :show
      expect(assigns(:tasks)).to eq Task.first(4)
    end
  end
end
