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

  end
end
