module Evvnt
  # Internal: Template methods to provide default behaviour for API actions.
  #
  # These are defined on Evvnt::Base subclasses where required to map the Evvnt API
  # actions.
  module ClassTemplateMethods
    # frozen_string_literal: true

    ##
    # Regular expression for params in URL strings
    PARAM_REGEX = %r{\:[^\/$]+}

    # Template method for creating a new record on the API.
    #
    # params - A Hash of params to send to the API.
    #
    # Returns {Evvnt::Base} subclass
    def create(**params)
      api_request(:post, resource_path, params: params)
    end

    # Template method for fetching an index of record from the API.
    #
    # params - A Hash of params to send to the API.
    #
    # Returns Array
    def index(**params)
      params.stringify_keys!
      if resource_path.respond_to?(:call)
        path = resource_path.call
        path.match(PARAM_REGEX) do |segment|
          value = params.delete(segment.to_s[1..-1])
          path  = path.gsub!(/#{segment}/, value.to_s)
        end
      else
        path = resource_path
      end
      api_request(:get, path, params: params)
    end

    # Template method for creating a given record
    #
    # record_id - An Integer or String representing the record ID on the API.
    # params    - A Hash of params to send to the API.
    #
    # Returns {Evvnt::Base} subclass
    def show(record_id = nil, **params)
      if record_id.nil? && !singular_resource?
        raise ArgumentError, "record_id cannot be nil"
      end
      path = singular_path_for_record(record_id, params)
      api_request(:get, path, params: params)
    end

    # Template method for updating a given record
    #
    # record_id - An Integer or String representing the record ID on the API.
    # params    - A Hash of params to send to the API.
    #
    # Returns {Evvnt::Base} subclass
    def update(record_id, **params)
      if record_id.nil? && !singular_resource?
        raise ArgumentError, "record_id cannot be nil"
      end
      path = singular_path_for_record(record_id, params)
      api_request(:put, path, params: params)
    end

    # Template method for fetching _mine_ records from the API.
    #
    # record_id - An Integer or String representing the record ID on the API (optional).
    # params    - A Hash of params to send to the API.
    #
    # Returns Array
    # Returns {Evvnt::Base}
    def ours(record_id = nil, **params)
      id_segment = record_id.to_s
      segments   = [resource_path, "ours", id_segment].select(&:present?)
      path       = File.join(*segments).to_s
      api_request(:get, path, params: params)
    end

    # Template method for fetching _mine_ records from the API.
    #
    # params    - A Hash of params to send to the API.
    #
    # Returns Array
    def mine(**params)
      path = File.join(resource_path, "mine").to_s
      api_request(:get, path, params: params)
    end
  end
end
