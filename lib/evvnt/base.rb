module Evvnt
  # Internal: Base class for Evvnt API resource classes.
  #
  class Base
    # frozen_string_literal: true

    require "evvnt/actions"
    require "evvnt/attributes"
    require "evvnt/api"
    require "evvnt/class_template_methods"
    require "evvnt/instance_template_methods"
    require "evvnt/logging"
    require "evvnt/nested_resources"
    require "evvnt/path_helpers"
    require "evvnt/persistence"

    include HTTParty
    include Logging
    include Api
    include Persistence
    include Attributes
    extend PathHelpers
    extend NestedResources
    extend Actions


    if Evvnt.configuration.environment == :live
      base_uri "https://api.evvnt.com"
    else
      base_uri "https://api.sandbox.evvnt.com"
    end


    # =================
    # = Class Methods =
    # =================

    ##
    # The first record from the API index actions
    #
    # Returns {Evvnt::Base} subclass
    def self.first
      defined_actions.include?(:index) ? all.first : method_missing(:first)
    end

    ##
    # The last record from the API index actions
    #
    # Returns {Evvnt::Base} subclass
    def self.last
      defined_actions.include?(:index) ? all.first : method_missing(:last)
    end



  end
end
