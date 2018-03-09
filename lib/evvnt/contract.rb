module Evvnt
  # Public: Returns contract info from the EVVNT API
  class Contract < Evvnt::Base

    ##
    # The JSON key for the package data from the API response.
    OBJECT_KEY = "package_options".freeze

    singular_resource!

    ##
    # GET /contract Get contract information
    define_action :index do
      api_request(:get, plural_resource_path, options: { object: OBJECT_KEY })
    end

  end
end
