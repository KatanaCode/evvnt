require "active_support/core_ext/object/inclusion"
require "active_support/configurable"
require "active_support/concern"
require "active_support/core_ext/string"
require "active_support/core_ext/hash"
require "active_support/hash_with_indifferent_access"

require 'logger'
require 'httparty'
require "evvnt/version"

module Evvnt
  # frozen_string_literal: true

  include ActiveSupport::Configurable

  config.environment = :sandbox

  config.logger = Logger.new($stdout)

  config.debug = false

  config.api_key = ENV["EVVNT_API_KEY"]

  config.api_secret = ENV["EVVNT_API_SECRET"]

  require "evvnt/base"
  require "evvnt/category"
  require "evvnt/contract"
  require "evvnt/event"
  require "evvnt/package"
  require "evvnt/published_event"
  require "evvnt/publisher"
  require "evvnt/report"
  require "evvnt/user"

end
