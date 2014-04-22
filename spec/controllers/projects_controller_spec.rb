require "spec_helper"

describe ProjectsController do
  let(:project) { build(:project) }
  subject { response }

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(subject).to render_template "new"
    end
  end
end
