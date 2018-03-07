module Evvnt
  # Internal: Helper methods defining API paths for the defined resources
  module PathHelpers
    ##
    # A regular expression to check for params in a URL String.
    PARAM_REGEX = %r{\:[^\/$]+}

    # Is this class defined as a singular resource?
    #
    # Returns Boolean
    def singular_resource?
      @singular_resource == true
    end

    # Declare this class as a singular resource
    #
    def singular_resource!
      @singular_resource = true
      resource_name(name.split("::").last.underscore.singularize)
    end

    # The name for this class's corresponding resource on the API.
    #
    # rename - A String representing the new resource_name.
    #
    def resource_name(rename = nil)
      if rename
        @resource_name = rename
      else
        @resource_name || default_resource_name
      end
    end

    # Nest a given resource path within a parent resource.
    #
    # path   - A String representing an API resource path.
    # params - A Hash of params to send to the API.
    #
    # Examples
    #
    #   nest_path_within_parent("bags/1", {user_id: "123"}) # => /users/123/bags/1
    #
    # Returns String
    def nest_path_within_parent(path, params)
      parent_resource = parent_resource_name(params)
      parent_id       = params.delete(parent_resource_param(params)).try(:to_s)
      File.join(parent_resource, parent_id, path).to_s
    end

    # The API path for a single resource on the API
    #
    # Returns String
    def singular_resource_path
      if singular_resource?
        resource_name
      else
        "#{resource_name}/:id"
      end
    end

    # The default name of this resource on the API (e.g. "users")
    #
    # Returns String
    def default_resource_name
      name.split("::").last.underscore.pluralize
    end

    # The defined path of this resource on the API (e.g. "/users")
    #
    # new_path - A String with the new default value for the resource_path
    # block    - A Proc object for defining dynamic resource_paths
    #
    # Returns String
    # Returns Proc
    def resource_path(new_path = nil, &block)
      if new_path || block_given?
        @resource_path = (new_path || block)
      else
        @resource_path || default_resource_path
      end
    end

    # The default path of this resource on the API (e.g. "/users")
    #
    # Returns String
    def default_resource_path
      resource_name
    end

    # Template method for fetching _mine_ records from the API.
    #
    # record_id - A String or Integer ID for the record we're fetching from the API.
    # params    - A Hash of parameters to send to the API.
    #
    # Returns String
    def singular_path_for_record(record_id, params)
      if singular_resource_path.respond_to?(:call)
        path = singular_resource_path.call
        path.match(PARAM_REGEX) do |segment|
          value = params.delete(segment.to_s[1..-1])
          path  = path.gsub!(/#{segment}/, value.to_s)
        end
      else
        path = singular_resource_path
      end
      path = path.gsub(/\:id/, record_id.to_s)
      if params_include_parent_resource_id?(params)
        path = nest_path_within_parent(path, params)
      end
      path
    end
  end
end
