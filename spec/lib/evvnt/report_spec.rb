require "spec_helper"

describe Evvnt::Report, type: :api do

  describe "::report" do

    before do
      stub_api_request(:get, "events/1234/report")
    end

    subject { Evvnt::Report.show(event_id: 1234) }

    it "returns a Report" do
      expect(subject).to be_a(Evvnt::Report)
    end

    it "sets broadcasts as a Broadcast" do
      expect(subject.broadcasts).to be_a(Array)
      expect(subject.broadcasts).to have_at_least(1).item
      expect(subject.broadcasts.first).to be_a(Evvnt::Broadcast)
    end

    it "sets broadcast_results as an Array" do
      expect(subject.broadcast_results).to be_a(Evvnt::BroadcastResult)
    end

    it "sets audience_reach as an AudienceReach" do
      expect(subject.audience_reach).to be_a(Evvnt::AudienceReach)
    end

    it "sets referrers as an Array of Referrer" do
      expect(subject.referrers).to be_a(Array)
      expect(subject.referrers).to have_at_least(1).item
      expect(subject.referrers.first).to be_a(Evvnt::Referrer)
    end

    it "sets search_indexing as an Array of SearchIndexings" do
      expect(subject.search_indexing).to be_a(Array)
      expect(subject.search_indexing).to have_at_least(1).item
      expect(subject.search_indexing.first).to be_a(Evvnt::SearchIndexing)
    end

    it "sets clicks_by_day to an Array of ClicksPerDay" do
      expect(subject.clicks_by_day).to be_a(Array)
      expect(subject.clicks_by_day).to have_at_least(1).item
      expect(subject.clicks_by_day.first).to be_a(Evvnt::ClicksByDay)
    end
  end

end
