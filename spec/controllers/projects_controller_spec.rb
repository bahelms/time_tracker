require "spec_helper"

describe ProjectsController do
  render_views
  let(:user) { create(:user) }
  before { sign_in user }
  subject { response }

  describe "GET #index" do
    before(:each) do
      create_projects
    end

    it "renders the index page" do
      get :index
      expect(subject).to render_template "index"
    end
  end

  describe "POST #create" do
    context "(with a name)" do
      it "creates a new project" do
        expect do
          post :create, project: { name: "Project88" }
        end.to change(Project, :count).by(1)
      end
    end

    context "(without a name)" do
      it "does not create a project" do
        expect { post :create, project: { name: nil } }.to raise_exception
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:project) { create(:project, user_id: user.id) }

    it "deletes the project" do
      expect do
        delete :destroy, id: project.id
      end.to change(Project, :count).by(-1)
    end
  end
end
