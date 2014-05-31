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
end
