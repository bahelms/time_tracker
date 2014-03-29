require "spec_helper"

describe TasksController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "POST #create" do
    let!(:task_params) do
      { task: { name: "test task", project_id: "" } }
    end

    it "creates a new task" do
      expect { post :create, task_params }.to change(Task, :count).by(1)
    end

    context "with time data" do
      let!(:time_data) do
        { time: { start_time: "", stop_time: "", duration: 60 } }
      end

      before(:each) do
        task_params[:task] = task_params[:task].merge(time_data)
        post :create, task_params
      end

      it "saves it in an hstore", :focus do
        expect(Task.first.time["duration"].to_i).to eq 60
      end
    end
  end
end
