# Public: Returns events info from the EVVNT API
class Evvnt::Event < Evvnt::Base

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

end
