require "spec_helper"

describe TimeConverter do
  let(:date) { Time.now }
  subject { described_class.new("2:17:19", "PM", date) }

  its(:time_string) { should eq "2:17:19" }
  its(:period) { should eq "PM" }
  its(:date) { should eq date }

  describe "#convert" do
    it "converts a time string into a Time object" do
      converter = described_class.new("2:17:19", "PM", date)
      converted_time = Time.new(date.year, date.month, date.day, 14, 17, 19)
      expect(converter.convert).to eq converted_time
    end
  end
end
