require "spec_helper"

describe Evvnt::Event, type: :api do

  describe "::index" do

    before do
      stub_api_request(:get, "events")
    end

    subject { Evvnt::Event.index }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end

    it "returns Events" do
      subject.each do |event|
        expect(event).to be_a(Evvnt::Event)
      end
    end

    it "has the expected attributes" do
      subject.each do |event|
        expect(event).to respond_to :id
        expect(event).to respond_to :title
        expect(event).to respond_to :category_id
        expect(event).to respond_to :sub_category_ids
        expect(event).to respond_to :timestamp
        expect(event).to respond_to :start_time
        expect(event).to respond_to :end_time
        expect(event).to respond_to :summary
        expect(event).to respond_to :description
        expect(event).to respond_to :image_urls
        expect(event).to respond_to :organiser_name
        expect(event).to respond_to :contact
        expect(event.contact).to be_a(Evvnt::Contact)
        expect(event.venue).to be_a(Evvnt::Venue)
        expect(event.links).to be_a(Array)
        expect(event.prices).to be_a(Array)
      end
    end

  end

  describe "::show" do

    before do
      stub_api_request(:get, "events/12345")
    end

    subject { Evvnt::Event.show(12345) }

    it "has the expected attributes" do
      expect(subject).to respond_to :id
      expect(subject).to respond_to :title
      expect(subject).to respond_to :category_id
      expect(subject).to respond_to :sub_category_ids
      expect(subject).to respond_to :timestamp
      expect(subject).to respond_to :start_time
      expect(subject).to respond_to :end_time
      expect(subject).to respond_to :summary
      expect(subject).to respond_to :description
      expect(subject).to respond_to :image_urls
      expect(subject).to respond_to :organiser_name
      expect(subject).to respond_to :contact
      expect(subject.contact).to be_a(Evvnt::Contact)
      expect(subject.venue).to be_a(Evvnt::Venue)
      expect(subject.links).to be_a(Array)
      expect(subject.prices).to be_a(Array)
    end

  end

end
