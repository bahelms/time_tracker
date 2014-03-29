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

    context "(with time data)" do
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

  describe "PATCH #update" do
    let!(:task) { create(:task, user_id: user.id) }

    context "(with a task name)" do
      before(:each) do
        patch :update, id: task.id, task: { name: "Bilbo" }
      end

      it "updates the task name" do
        expect(Task.find(task.id).name).to eq "Bilbo"
      end
    end

    context "(with time data)" do
      let!(:time_data) { { "stop_time" => "", "duration" => "" } }
      before(:each) do
        patch :update, id: task.id, task: { time: time_data }
      end

      it "updates the time hash" do
        task_time = Task.find(task.id).time
        expect(task_time).to eq time_data.merge({ "start_time" => task_time[:start_time]})
      end
    end
  end
end
