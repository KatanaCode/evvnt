module Evvnt
  # Fetch EVVNT Categories from the API
  class Category < Evvnt::Base

    ##
    # The ID of the "All" category on Evvnt
    DEFAULT_ID = 26

    ##
    # GET /categories List categories
    # Returns Array
    define_action :index

    belongs_to :publisher

  end
end
