# Internal: Base class for Evvnt API resource classes.
#
class Evvnt::Base
  # frozen_string_literal: true

  require "evvnt/logging"
  require "evvnt/api"
  require "evvnt/path_helpers"
  require "evvnt/nested_resources"
  require "evvnt/actions"
  require "evvnt/class_template_methods"
  require "evvnt/instance_template_methods"

  include HTTParty
  include Evvnt::Logging
  include Evvnt::Api
  extend Evvnt::PathHelpers
  extend Evvnt::NestedResources
  extend Evvnt::Actions

  if Evvnt.config.environment == :live
    base_uri "https://api.evvnt.com"
  else
    base_uri "https://api.sandbox.evvnt.com"
  end

  ##
  # The attributes for this given record
  #
  # Returns Hash
  attr_reader :attributes

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


  # ====================
  # = Instance methods =
  # ====================

  ##
  # Initialize a new record
  #
  # attributes - A Hash of attributes for the given record. See {method_missing} for
  #              more info on how this is handled.
  def initialize(attributes = {})
    self.attributes = attributes
  end

  # Has this record been saved on the EVVNT API?
  #
  # Returns a Boolean
  def persisted?
    unique_identifier.present?
  end

  # Is this record an unsaved/fresh record?
  #
  # Returns a Boolean
  def new_record?
    unique_identifier.blank?
  end

  # Save this record to the EVVNT API
  #
  # Returns {Evvnt::Base} subclass
  def save
    new_record? ? save_as_new_record : save_as_persisted_record
  end

  ##
  # Set or change the attributes for this record
  #
  # hash - A Hash of attributes for this record.
  #
  # Raises ArgumentError If hash is not an instance of Hash
  # Returns Hash
  def attributes=(hash)
    if hash.is_a?(Hash)
      @attributes = hash.with_indifferent_access
    else
      raise ArgumentError, "Invalid attributes for #{self}: #{hash}"
    end
  end

  # The unique identifier for the given record. Tries +uuid+ followed by +id+.
  #
  # Returns String
  def unique_identifier
    attributes["uuid"] || attributes["id"]
  end

  private

    ##
    # Overrides method missing to catch undefined methods. If +method_name+ is one
    # of the keys on +attributes+, returns the value of that attribute. If +method_name+
    # is not one of +attributes+, passes up the chain to super.
    #
    # method_name - Symbol of the name of the method we're testing for.
    # args        - Array of arguments send with the original mesage.
    # block       - Proc of code passed with original message.
    #
    def method_missing(method_name, *args, &block)
      if method_name.to_s[/\=/]
        attributes[method_name.to_s.gsub(/\=+/, "")] = args.first
      else
        attributes[method_name.to_s.gsub(/\=+/, "")]
      end
    end

    # Save this record to the EVVNT API as a new record using the +create+ action.
    #
    def save_as_new_record
      new_attributes = attributes.reject { |k, v| k.to_s =~ /^(id|uuid)$/ }
      self.class.create(new_attributes)
    end

    # Save this record to the EVVNT API as an existing record using the +update+ action.
    #
    def save_as_persisted_record
      new_attributes = attributes.reject { |k, v| k.to_s =~ /^(id|uuid)$/ }
      self.class.update(id, new_attributes)
    end
end
