require "spec_helper"

describe Evvnt::PublishedEvent do

  describe "::index" do

    before do
      stub_api_request(:get, "publishers/324/published_events")
    end

    subject { Evvnt::PublishedEvent.index(publisher_id: 324) }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end

    it "returns PublishedEvents" do
      subject.each do |published_event|
        expect(published_event).to be_a(Evvnt::PublishedEvent)
      end
    end

    it "adds the correct attributes to published events" do
      subject.each do |published_event|
        expect(published_event).to respond_to :publisher_id
        expect(published_event).to respond_to :event_id
        expect(published_event).to respond_to :url
        expect(published_event).to respond_to :event_title
        expect(published_event).to respond_to :event_start_time
        expect(published_event.event_start_time).to be_a(DateTime)
      end
    end

  end

  describe "::show" do

    before do
      stub_api_request(:get, "publishers/324/published_events/1385")
    end

    subject { Evvnt::PublishedEvent.show(1385, publisher_id: 324) }

    it "returns a Evvnt::PublishedEvent" do
      expect(subject).to be_a(Evvnt::PublishedEvent)
    end

    it "adds the correct attributes to published events" do
      expect(subject.publisher_id).to eql(324)
      expect(subject.event_id).to eql(1385)
      expect(subject.url).to eql(nil)
      expect(subject.event_title).to eql("Accounting Conf 2")
      expect(subject.event_start_time).to eql("2014-05-10T15:00:00+01:00".to_datetime)
    end

  end

  describe "::update" do

    before do
      stub_api_request(:put, "publishers/324/published_events/1385",
                             params: { url: "http://new-url.example.com" })
    end

    subject {
      Evvnt::PublishedEvent.update(1385, publisher_id: 324,
                                         url: "http://new-url.example.com")
    }

    it "returns a Evvnt::PublishedEvent" do
      expect(subject).to be_a(Evvnt::PublishedEvent)
    end

  end

end
