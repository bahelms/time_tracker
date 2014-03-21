require "spec_helper"

describe DashboardController do
  let(:user) { create(:user) }
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "GET #show" do
    it "displays the title" do
      get :show
      expect(response).to be_success
    end
  end
end
