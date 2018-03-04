# Public: Represents published {Evvnt::Event Events} on the EVVNT API
class Evvnt::PublishedEvent < Evvnt::Base

  ##
  # GET /events List Events
  define_action :index

  ##
  # GET /events/:event_id Get one event
  define_action :show

  ##
  # PUT /events/:event_id Update an event
  define_action :update


  belongs_to :publisher

end
