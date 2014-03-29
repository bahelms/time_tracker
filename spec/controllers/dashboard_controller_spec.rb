require "spec_helper"

describe DashboardController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #show" do
    it "displays the title" do
      get :show
      expect(response).to be_success
    end
  end
end
