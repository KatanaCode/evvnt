module Evvnt
  # Public: Returns list of publishers from the EVVNT API.
  #
  class Publisher < Evvnt::Base

    ##
    # GET /publishers List my publishing sites
    define_action :index

  end
end
