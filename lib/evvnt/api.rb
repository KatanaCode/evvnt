# Internal: Handles requests to the EVVNT api and catches their responses.
module Evvnt::Api

  # frozen_string_literal: true

  extend ActiveSupport::Concern

  ##
  # Basic encoded API key and secret
  BASIC_ENCODED = Base64.encode64("#{Evvnt.config.api_key}:#{Evvnt.config.api_secret}")

  ##
  # Headers to be sent with every request.
  HEADERS = {
    "Authorization" => "Basic #{BASIC_ENCODED}",
    "Content-Type"  => "application/json",
    "Accept"        => "application/json"
  }

  ##
  # Allowed HTTP verbs
  HTTP_VERBS = %i[get post put]


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
        if verb.in?(HTTP_VERBS)
          path = sanitize_path(path)
          log_request(verb, path, params)
          response = public_send(verb, path, query: params, headers: HEADERS)
          log_response(response)
          parse_response(response, options)
        else
          raise ArgumentError, "Unrecognised HTTP verb '#{verb}'"
        end
      end

      # Log the request being sent to the API
      #
      # verb   - The HTTP verb for the request
      # path   - The path of the request
      # params - The request params being sent to the server
      #
      def log_request(verb, path, **params)
        return unless Evvnt.config.debug
        debug <<~TEXT
          Headers: #{HEADERS}")
          Request: #{verb.to_s.upcase} #{base_uri}#{path} #{params}
        TEXT
      end

      # Log the response from the API
      #
      # response - The Response object from the API
      #
      def log_response(response)
        return unless Evvnt.config.debug
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
        json = JSON.parse(response.body)
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
        path = path + ".json" unless path.ends_with?(".json")
        path
      end
  end
end
