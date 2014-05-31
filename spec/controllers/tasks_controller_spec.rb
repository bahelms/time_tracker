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
    # let(:project) { }

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

  describe "PATCH #manual_update" do
    let!(:task) { create_task(user, "1401513190", "1401556891") }
    let!(:time_params) do
      { id: task.id, start_time: " 1:23:10 pm", stop_time: " 2:51:04 pm" }
    end

    context "(when times are different)" do
      it "saves the new start time for the task" do
        old_start = task.start_time
        patch :manual_update, time_params
        expect(task.reload.start_time).not_to eq old_start
      end

      it "saves the new stop time for the task" do
        old_stop = task.stop_time
        patch :manual_update, time_params
        expect(task.reload.start_time).not_to eq old_stop
      end
    end

    context "(when times are the same)" do
      let!(:time_params2) do
        { id: task.id, start_time: " 1:13:10 pm", stop_time: " 2:51:04 pm" }
      end

      it "saves the new start time for the task" do
        old_start = task.start_time
        patch :manual_update, time_params2
        expect(task.reload.start_time).to eq old_start
      end
    end
  end

  def create_task(user, start, stop)
    create(:task,
           user_id: user.id,
           start_time: start,
           stop_time: stop)
  end
end
