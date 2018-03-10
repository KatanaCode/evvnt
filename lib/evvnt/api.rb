module Evvnt
  # Internal: Handles requests to the EVVNT api and catches their responses.
  module Api
    # frozen_string_literal: true
    require 'oj'
    require "evvnt/api_error"

    extend ActiveSupport::Concern

    ##
    # Allowed HTTP verbs
    HTTP_VERBS = %i[get post put].freeze

    included do
      if Evvnt.configuration.environment == :live
        base_uri "https://api.evvnt.com"
      else
        base_uri "https://api.sandbox.evvnt.com"
      end
    end


    # Class methods to define on {Evvnt::Base}
    module ClassMethods
      private

        # Make a request of the EVVNT API.
        #
        # verb    - The HTTP verb for the request.
        # path    - The path to request from the API.
        # params  - A Hash of query params to send with the request.
        # options - A Hash of additional options for the request.
        #
        # Returns HTTParty::Response
        # Raises ArgumentError if the verb is not valid
        def api_request(verb, path, params: {},  options: {})
          unless verb.in?(HTTP_VERBS)
            raise ArgumentError, "Unrecognised HTTP verb '#{verb}'"
          end
          path = sanitize_path(path)
          log_request(verb, path, params)
          response = public_send(verb, path, query: params, headers: headers)
          log_response(response)
          parse_response(response, options)
        end

        # Log the request being sent to the API
        #
        # verb   - A Symbol of the HTTP verb for the request
        # path   - A String of the path of the request
        # params - A Hash of the request params being sent to the server
        #
        def log_request(verb, path, params = {})
          return unless Evvnt.configuration.debug
          debug <<~TEXT
            Headers: #{headers}")
            Request: #{verb.to_s.upcase} #{base_uri}#{path} #{params}
          TEXT
        end

        # Log the response from the API
        #
        # response - The Response object from the API
        #
        def log_response(response)
          return unless Evvnt.configuration.debug
          debug <<~TEXT
            Response: #{response}
            Status: #{response.code}
          TEXT
        end

        ##
        # Parse a response from the API and create objects from local classes.
        #
        # response - Response object from HTTParty request.
        # options  - A Hash of options
        #
        # Returns Array
        # Returns Evvnt::Base subclass
        def parse_response(response, **options)
          json = Oj.load(response.body)
          json = json[options[:object]] if options.key?(:object)
          json.is_a?(Array) ? json.map { |a| new(a) } : new(json)
        end

        # Ensure the path is the correct format with a leading slash and ".json" extension
        #
        # path - A String with the API request path.
        #
        # Returns String
        def sanitize_path(path)
          path = "/"  + path    unless path.starts_with?('/')
          path += ".json" unless path.ends_with?(".json")
          path
        end

        ##
        # Headers to be sent with every request.
        #
        # Returns Hash
        def headers
          {
            "Authorization" => "Basic #{auth}",
            "Content-Type"  => "application/json",
            "Accept"        => "application/json"
          }
        end

        ##
        # Key and secret as Base64 string.
        def auth
          Base64.encode64([Evvnt.configuration.api_key,
                           Evvnt.configuration.api_secret].join(":"))
        end
    end
  end
end
