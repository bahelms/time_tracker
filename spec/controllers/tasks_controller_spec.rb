require "spec_helper"

describe TasksController do
  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    let!(:task_params) do
      { task: { name: "test task", project_id: "" } }
    end

    it "creates a new task" do
      expect { post :create, task_params }.to change(Task, :count).by(1)
    end

    context "(with a name)" do
      it "saves the task name" do
        post :create, task_params
        expect(Task.last.name).to eq task_params[:task][:name]
      end
    end

    context "(with time data)" do
      let(:task) { Task.first }
      let!(:time_data) do
        { start_time: 500, stop_time: 1000, duration: 60 }
      end

      before(:each) do
        task_params[:task] = task_params[:task].merge(time_data)
        post :create, task_params
      end

      it "saves it in an hstore" do
        expect(task.time).to be_an_instance_of Hash
      end

      it "saves start_time" do
        expect(task.start_time.to_i).to eq 500
      end

      it "saves stop_time" do
        expect(task.stop_time.to_i).to eq 1000
      end

      it "saves duration" do
        expect(task.duration.to_i).to eq 60
      end

      it "returns the task id in json" do
        expect(JSON.parse(response.body)["id"]).to eq Task.last.id
      end
    end
  end

  describe "PATCH #update" do
    let!(:task) { create(:task, user_id: user.id, start_time: 500) }
    let!(:time_data) { { "stop_time" => "203", "duration" => "123" } }
    let(:project) { }

    context "(with a task name)" do
      before(:each) do
        patch :update, id: task.id, task: { name: "Bilbo" }
      end

      it "updates the task name" do
        expect(Task.find(task.id).name).to eq "Bilbo"
      end
    end

    context "(with time data)" do
      before(:each) do
        patch :update, id: task.id, task: time_data
      end

      it "updates the time hash" do
        task_time = Task.find(task.id).time
        start_time = { "start_time" => task_time["start_time"] }
        expect(task_time).to eq time_data.merge(start_time)
      end
    end

    context "(with a project)" do
      let(:project_data) { time_data.merge({ project_id: 23 }) }

      before(:each) do
        patch :update, id: task.id, task: project_data
      end

      it "updates the project ID" do
        expect(task.reload.project_id).to eq 23
      end
    end

    it "renders the partial for all the tasks in the current week" do
      patch :update, id: task.id, task: time_data
      expect(response).to render_template partial: "_all_tasks_for_week"
    end
  end
end
