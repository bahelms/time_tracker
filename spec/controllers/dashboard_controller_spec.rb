require "spec_helper"

describe DashboardController do
  before do
    controller.stub(:authenticate!).and_return true
  end

  describe "GET #show" do
    it "displays the title" do
      get :show
    end
  end
end
