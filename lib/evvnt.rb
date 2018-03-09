require "active_support/core_ext/object/inclusion"
require "active_support/configurable"
require "active_support/concern"
require "active_support/core_ext/string"
require "active_support/core_ext/hash"
require "active_support/hash_with_indifferent_access"

require 'logger'
require 'httparty'
require "evvnt/version"
require "evvnt/configuration"

# Master module for Evvnt functionality.
module Evvnt
  # frozen_string_literal: true

  module_function

  def configure(&block)
    @configuration = Evvnt::Configuration.new(&block)
  end

  def configuration
    @configuration ||= configure
  end

  require "evvnt/base"
  require "evvnt/audience_reach"
  require "evvnt/broadcast"
  require "evvnt/broadcast_result"
  require "evvnt/category"
  require "evvnt/clicks_by_day"
  require "evvnt/contact"
  require "evvnt/contract"
  require "evvnt/event"
  require "evvnt/link"
  require "evvnt/package"
  require "evvnt/price"
  require "evvnt/published_event"
  require "evvnt/publisher"
  require "evvnt/referrer"
  require "evvnt/report"
  require "evvnt/search_indexing"
  require "evvnt/user"
  require "evvnt/venue"
end
