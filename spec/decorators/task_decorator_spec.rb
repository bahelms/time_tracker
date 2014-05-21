require "spec_helper"

describe TaskDecorator do
  let(:task) { build(:task) }
  subject(:decorator) { TaskDecorator.new(task) }

  describe "#initialize" do
    context "when @name is blank" do
      it "sets @name to a default" do
        expect(decorator.name).to eq "(unknown task)"
      end
    end
  end

  describe "#project_name" do
    context "(when project ID is nil)" do
      it "sets project name to nil" do
        expect(decorator.project_name).to eq nil
      end
    end
  end

  describe "#find_duration" do
    context "(when less than a minute)" do
      it "returns seconds" do
        task.duration = 45
        expect(decorator.find_duration).to eq "45 secs"
      end
    end

    context "(when over a minute and less than an hour)" do
      it "returns mintues" do
        task.duration = 837
        expect(decorator.find_duration).to eq "13 mins"
      end
    end

    context "(when over an hour)" do
      it "returns hours" do
        task.duration = 12084
        expect(decorator.find_duration).to eq "3 hours"
      end
    end
  end
end
