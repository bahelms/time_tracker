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

    context "(with a task name)" do
      before(:each) do
        patch :update, id: task.id, task: { name: "Bilbo" }
      end

      it "updates the task name" do
        expect(Task.find(task.id).name).to eq "Bilbo"
      end
    end

    context "(with time data)" do
      let!(:time_data) { { "stop_time" => "203", "duration" => "123" } }
      before(:each) do
        patch :update, id: task.id, task: time_data
      end

      it "updates the time hash" do
        task_time = Task.find(task.id).time
        expect(task_time).to eq time_data.merge({ "start_time" => task_time["start_time"]})
      end
    end

    context "(when a day has only one task)" do
      it "renders the partial for the whole day" do
        pending "Need to change where coffeescript injects this partial"
      end
    end

    context "(when a day has more than one task)" do
      let(:task2) { create(:task, user_id: user.id, start_time: 1000) }

      it "renders a partial for the latest task" do
        expect do
          patch :update, id: task2.id, task: time_data
        end.to render_template partial: "_task"
      end
    end
  end
end
