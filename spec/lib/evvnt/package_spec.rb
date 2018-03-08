require "spec_helper"

describe Evvnt::Package, type: :api do

  describe "::index" do

    context "when user_id is present" do

      subject { Evvnt::Package.index(user_id: "ffcdd57c-243e-4d71-ab50-a0ca765bbe54") }

      before do
        stub_api_request(:get, "users/ffcdd57c-243e-4d71-ab50-a0ca765bbe54/packages")
      end

      it "returns an Array" do
        expect(subject).to be_an(Array)
      end

    end

    context "when user_id is not present" do

      subject { Evvnt::Package.index }

      before do
        stub_api_request(:get, "packages")
      end

      it "returns an empty Array" do
        expect(subject).to be_a(Array)
        expect(subject).to be_empty
      end

    end

  end

  describe "::create" do

    subject { Evvnt::Package.create(user_id: "ffcdd57c-243e-4d71-ab50-a0ca765bbe54",
                                    id: 131, event_quantity: 2,
                                    event_quantity_remaining: 1) }

    before do
      stub_api_request(:post, "users/ffcdd57c-243e-4d71-ab50-a0ca765bbe54/packages",
                       params: {id: 131, event_quantity: 2, event_quantity_remaining: 1})
    end

    it "returns a Package object" do
      expect(subject).to be_a(Evvnt::Package)
    end

    it "returns an objet with the expected attributes" do
      expect(subject).to respond_to :id
    end

  end

  describe "::show" do

    subject { Evvnt::Package.show("550e8400-e29b-41d4-a716-446655440000") }

    before do
      stub_api_request(:get, "packages/550e8400-e29b-41d4-a716-446655440000")
    end

    it "returns an Array object" do
      expect(subject).to be_a(Evvnt::Package)
    end

    it "returns an objet with the expected attributes" do
      expect(subject.uuid).to eql("550e8400-e29b-41d4-a716-446655440000")
      expect(subject.type).to eql("SinglePackage")
      expect(subject.broadcast_volume).to eql(60)
      expect(subject.event_quantity).to eql(5)
      expect(subject.purchase_order_id).to eql("PO235")
      expect(subject.notes).to eql("")
      expect(subject.purchase_date).to eql("2014-01-01".to_date)
    end

  end

  describe "::mine" do

    subject { Evvnt::Package.mine }

    before do
      stub_api_request(:get, "packages/mine")
    end

    it "returns an Array object" do
      expect(subject).to be_a(Array)
    end

    it "returns an objet with the expected attributes" do
      subject.each do |package|
        expect(package).to respond_to :uuid
        expect(package).to respond_to :type
        expect(package).to respond_to :broadcast_volume
        expect(package).to respond_to :event_quantity
        expect(package).to respond_to :purchase_order_id
        expect(package).to respond_to :notes
        expect(package).to respond_to :purchase_date
      end
    end

  end

end
