require "spec_helper"

describe Evvnt::Event, type: :api do

  describe "::create" do

    let(:attributes) {
      {
        "title": "An Event Title",
        "category_id": 17,
        "start_time": "2018-06-23T22:00:00+0100",
        "end_time": "2018-06-24T03:00:00+0100",
        "summary": "This is an example event summary\nIt may have up to 200 characters.",
        "description": "This is the complete event description. Line breaks still look",
        "image_urls": ["https://www.evvnt.com/assets/evvnt-logo-turquoise-eef2bd741d1234a691af6d8cfdbc067e.png"],
        "organiser_name": "Event Organiser Ltd",
        "contact": {
          "name": "John Smith",
          "email": "johnsmith@example.com",
          "tel": "020 1111 2222"
        },
        "venue": {
          "name": "evvnt",
          "address_1": "17a Newman Street",
          "address_2": "Fitzrovia",
          "town": "London",
          "country": "GB",
          "postcode": "W1T 1PD",
          "latitude": 51.517337,
          "longitude": -0.135175
        },
        "links": {
          "Website": "http://example.com/url1",
          "Twitter": "http://example.com/url2",
          "Booking": "http://example.com/url3"
        },
        "prices": {
          "price 1": "GBP 50",
          "price 2": "GBP 100"
        },
        "artists": "ELon Musk, Mark Zuckerberg",
        "keywords": "Example, Event, Keywords",
        "hashtag": "event2018"
      }
    }

    before do
      stub_api_request(:post, "events", params: attributes)
    end

    subject {
      Evvnt::Event.create(attributes)
    }

    it "returns the ID of the Event" do
      expect(subject).to respond_to :id
    end

  end

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
        expect(event.image_urls).to be_a(Array)
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

  describe "::update" do

    let!(:attributes) {
      {
        "title": "The Updated Event Title",
        "start_time": "2013-06-23T22:30:00+0100",
        "image_urls": ["http://example.com/the_url_of_the_updated_image_associated_with_the_event"]
      }
    }

    before do
      stub_api_request(:put, "events/12345", params: attributes)
    end

    subject { Evvnt::Event.update(12345, attributes) }

    it "doesn't raise any errors" do
      expect { subject }.not_to raise_error
    end

  end

  describe "::mine" do

    before do
      stub_api_request(:get, "events/mine")
    end

    subject { Evvnt::Event.mine }

    it "returns an Array" do
      expect(subject).to be_an(Array)
    end

  end

  describe "::ours" do

    context "without event ID" do

      before do
        stub_api_request(:get, "events/ours")
      end

      subject { Evvnt::Event.ours }

      it "returns an Array" do
        expect(subject).to be_an(Array)
      end

    end

    context "with event ID" do

      before do
        stub_api_request(:get, "events/ours/12345")
      end

      subject { Evvnt::Event.ours(12345) }

      it "returns an Event" do
        expect(subject).to be_an(Evvnt::Event)
      end

    end

  end
end
