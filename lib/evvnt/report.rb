module Evvnt
  # Public: Returns report for a given {Evvnt::Event} from the API.
  #
  # Examples
  #
  #   Evvnt::Report.find(event_id: '...')
  #
  class Report < Evvnt::Base

    singular_resource!

    belongs_to :event

    ##
    # GET /events/:event_id/report View report data for my event
    define_action :show

    private

    def format_hash_attribute(key, value)
      case key
      when %r{^(referrers|search\_indexing)$}
        send(:"format_#{key}_attribute", key, value)
      else
        super
      end
    end

    def format_array_attribute(key, value)
      case key
      when %r{^(clicks\_by\_day|broadcasts)$}
        send(:"format_#{key}_attribute", key, value)
      else
        super
      end
    end

    def format_referrers_attribute(key, value)
      value.to_a.map { |url, count| Evvnt::Referrer.new(url: url, count: count) }
    end

    def format_search_indexing_attribute(key, value)
      value.to_a.map { |name, url| Evvnt::SearchIndexing.new(name: name, url: url) }
    end

    def format_broadcasts_attribute(key, value)
      Array(value).map { |atts| Evvnt::Broadcast.new(atts) }
    end

    def format_clicks_by_day_attribute(key, value)
      value.to_a[1..-1].map do |date, twitter, myspace, total|
        Evvnt::ClicksByDay.new(date: date, twitter: twitter,
                               myspace: myspace, total: total)
      end
    end

  end
end
