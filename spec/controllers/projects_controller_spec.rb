require "spec_helper"

describe ProjectsController do
  let(:project) { build(:project) }
  subject { response }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(subject).to render_template "new"
    end
  end
end
