module Evvnt
  # Public: Returns events info from the EVVNT API
  class Event < Evvnt::Base

    ##
    # GET /events List Events
    define_action :index

    ##
    # GET /events/:event_id Get one event
    define_action :show

    ##
    # POST /events  Create an event
    define_action :create

    ##
    # PUT /events/:event_id  Update an event
    define_action :update

    ##
    # GET /events/ours(/:id) Get events of you and your created users
    define_action :ours

    ##
    # GET /events/mine  List my events
    define_action :mine


    private


    def format_hash_attribute(key, value)
      case key
      when "links"
        format_links_attribute(key, value)
      when "prices"
        format_prices_attribute(key, value)
      else
        super
      end
    end

    def format_links_attribute(key, value)
      value.to_a.map { |name, url| Evvnt::Link.new(name: name, url: url) }
    end

    def format_prices_attribute(key, value)
      value.to_a.map { |name, price| Evvnt::Price.new(name: name, value: price) }
    end
  end
end
