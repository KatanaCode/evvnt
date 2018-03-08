require "spec_helper"

describe Evvnt::Category, type: :api do

  describe "::index" do

    before do
      stub_api_request(:get, "categories")
    end

    subject { Evvnt::Category.index }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end

    it "returns Categories" do
      subject.each do |category|
        expect(category).to be_a(Evvnt::Category)
      end
    end

    it "has the expected attributes" do
      subject.each do |category|
        expect(category).to respond_to :id
        expect(category).to respond_to :parent_id
        expect(category).to respond_to :name
      end
    end

  end

end
