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

  end
end
