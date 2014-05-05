require "spec_helper"

describe ReportsController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
