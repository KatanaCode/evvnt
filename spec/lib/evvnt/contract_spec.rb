require "spec_helper"

describe Evvnt::Contract, type: :api do

  describe "::index" do

    before do
      stub_api_request(:get, "contract")
    end

    it "returns an Array" do
      expect(Evvnt::Contract.index).to be_an_instance_of(Array)
    end

    it "expects each object to have the correct attributes" do
      Evvnt::Contract.index.each do |package|
        expect(package).to respond_to :id
        expect(package).to respond_to :type
        expect(package).to respond_to :broadcast_volume
        expect(package).to respond_to :currency
        expect(package).to respond_to :cost_per_event
      end
    end

    it "returns an array of Contract objects" do
      Evvnt::Contract.index.each do |package|
        expect(package).to be_a(Evvnt::Contract)
      end
    end

  end

end
