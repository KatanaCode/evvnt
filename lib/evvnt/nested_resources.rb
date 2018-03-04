# Internal: Adds behaviour to {Evvnt::Base} for handling nested resources
#
# Examples
#
#   class Thing < Evvnt::Base
#     belongs_to :user
#   end
#   # Will find a Thing at "/users/456/things/123.json"
#   @thing = Thing.find("123", user_id: "456")
#
module Evvnt::NestedResources
  # frozen_string_literal: true

  private

    # Tell a class that it's resources may be nested within another named resource
    #
    # parent_resource - A Symbol with the name of the parent resource.
    #
    def belongs_to(parent_resource)
      parent_resource = parent_resource.to_sym
      parent_resources << parent_resource unless parent_resource.in?(parent_resources)
    end

    # A list of the parent resources for this class.
    #
    # Return Array
    def parent_resources
      @parent_resources ||= []
    end

    # A list of the param names that represent parent resources
    #
    # Returns Array
    def parent_resource_id_params
      parent_resources.map { |pr| :"#{pr}_id" }
    end

    # Does the params hash contain a parent resource ID?
    #
    # params - A Hash of params to send to the API.
    #
    # Returns Boolean
    def params_include_parent_resource_id?(params)
      parent_resource_param(params).present?
    end

    # The param that represents the parent record (e.g. +:user_id+)
    #
    # params - A Hash of params to send to the API.
    #
    # Returns Symbol
    def parent_resource_param(params)
      (params.symbolize_keys.keys & parent_resource_id_params).first
    end

    # The name of the parent record defined in the parms
    #
    # params - A Hash of params to send to the API.
    #
    def parent_resource_name(params)
      parent_resource_param(params).to_s.gsub(/\_id/, '').pluralize
    end
end
