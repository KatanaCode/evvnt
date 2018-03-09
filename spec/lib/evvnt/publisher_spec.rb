require "spec_helper"

describe Evvnt::Publisher do

  describe "::index" do

    before do
      stub_api_request(:get, "publishers")
    end

    subject { Evvnt::Publisher.index }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end

    it "returns an Array of Publishers" do
      subject.each do |publisher|
        expect(publisher).to respond_to(:id)
        expect(publisher).to respond_to(:name)
        expect(publisher).to respond_to(:url)
      end
    end

  end

end
