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

    # The name for this class's corresponding resource on the API.
    def resource_name
      @resource_name || default_resource_name
    end


    protected

    # Declare this class as a singular resource
    #
    def singular_resource!
      @singular_resource = true
      self.resource_name = name.split("::").last.underscore.singularize
    end

    def resource_name=(value)
      @resource_name = value
    end

    private

    # The default name of this resource on the API (e.g. "users")
    #
    # Returns String
    def default_resource_name
      @default_resource_name || name.split("::").last.underscore.pluralize
    end

    # The default path of this resource on the API (e.g. "/users")
    #
    # Returns String
    def default_resource_path
      resource_name
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
      return path unless params_include_parent_resource_id?(params)
      params.symbolize_keys!
      parent_resource = parent_resource_name(params)
      parent_id       = params.delete(parent_resource_param(params)).try(:to_s)
      File.join(*[parent_resource, parent_id, path].compact).to_s
    end

    # The API path for a single resource on the API
    #
    # Returns String
    def singular_resource_path
      return resource_name if singular_resource?
      "#{resource_name}/:id"
    end

    def plural_resource_path
      @plural_resource_path ||= default_resource_path
    end

    # Template method for fetching _mine_ records from the API.
    #
    # record_id - A String or Integer ID for the record we're fetching from the API.
    # params    - A Hash of parameters to send to the API.
    #
    # Returns String
    def singular_path_for_record(record_id, _params)
      singular_resource_path.gsub(/\:id/, record_id.to_s)
    end
  end
end
