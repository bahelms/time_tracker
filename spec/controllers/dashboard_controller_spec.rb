require "spec_helper"

describe DashboardController do
  describe "GET #show" do
    it "displays the title" do
      get :show
    end
  end
end
