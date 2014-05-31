require "spec_helper"

describe TimePresenter do
  subject { Object.new.extend(TimePresenter) }

  describe "#pretty_time" do
    it "returns formatted time string" do
      expect(subject.pretty_time(500)).to eq "00:08:20"
    end
  end

  describe "#digits" do
    context "(when number is less than 10)" do
      it "returns a two character string starting with 0" do
        expect(subject.digits(4)).to eq "04"
      end
    end

    context "(when a number is more than 9)" do
      it "returns that number" do
        expect(subject.digits(34)).to eq 34
      end
    end
  end
end
