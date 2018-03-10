module Evvnt
  # Internal: NestedObject class for Evvnt API objects that don't map to a main
  # resource.
  #
  class NestedObject
    # frozen_string_literal: true

    require "evvnt/attributes"
    require "evvnt/logging"

    include Logging
    include Attributes
  end
end
