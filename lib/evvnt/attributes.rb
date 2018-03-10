module Evvnt
  module Attributes
    # frozen_string_literal: true

    extend ActiveSupport::Concern


    ##
    # Test if a String is a date string.
    DATE_STRING_REGEX = /^\d{4}-\d{2}-\d{2}$/

    ##
    # Test if a String is a datetime string.
    DATETIME_STRING_REGEX = /^\d{4}-\d\d-\d\dT\d\d\:\d\d\:\d\d\+\d\d\:\d\d$/

    ##
    # The attributes for this given record
    #
    # Returns Hash
    attr_reader :attributes


    ##
    # Initialize a new record
    #
    # attributes - A Hash of attributes for the given record. See {method_missing} for
    #              more info on how this is handled.
    def initialize(attributes = {})
      self.attributes = Hash[attributes.map { |k, v| [k, format_attribute(k, v)] }]
    end

    ##
    # Set or change the attributes for this record
    #
    # hash - A Hash of attributes for this record.
    #
    # Returns Hash
    def attributes=(hash)
      @attributes = Hash(hash).with_indifferent_access
    end

    # The unique identifier for the given record. Tries +uuid+ followed by +id+.
    #
    # Returns String
    def unique_identifier
      attributes["uuid"] || attributes["id"]
    end

    private

    def format_attribute(key, value)
      case value
      when String
        format_string_attribute(value)
      when Array
        format_array_attribute(key, value)
      when Hash
        format_hash_attribute(key, value)
      else
        value
      end
    end

    def format_hash_attribute(key, value)
      unless Evvnt.const_defined?(key.singularize.classify)
        raise ArgumentError, "Unknown object type: #{key}"
      end
      Evvnt.const_get(key.singularize.classify).new(value)
    end

    def format_array_attribute(key, value)
      Array(value).map do |attributes|
        unless Evvnt.const_defined?(key.singularize.classify)
          raise ArgumentError, "Unknown object type: #{key}"
        end
        Evvnt.const_get(key.singularize.classify).new(attributes)
      end
    end

    def format_string_attribute(value)
      case value
      when DATE_STRING_REGEX
        value.to_date
      when DATETIME_STRING_REGEX
        value.to_datetime
      else
        value
      end
    end

    ##
    # Overrides method missing to catch undefined methods. If +method_name+ is one
    # of the keys on +attributes+, returns the value of that attribute. If +method_name+
    # is not one of +attributes+, passes up the chain to super.
    #
    # method_name - Symbol of the name of the method we're testing for.
    # args        - Array of arguments send with the original mesage.
    # block       - Proc of code passed with original message.
    #
    def method_missing(method_name, *args)
      setter    = method_name.to_s.ends_with?('=')
      attr_name = method_name.to_s.gsub(/=$/, "")
      if setter
        attributes[attr_name] = args.first
      else
        attributes[attr_name]
      end
    end

    ##
    # Improve code instrospect. Allows `respond_to?` for dynamically added attribute
    # methods.
    #
    # method - A Symbol with the method name
    #
    # Returns Boolean
    def respond_to_missing?(method, *)
      attributes.stringify_keys.keys.include?(method.to_s) || super
    end
  end
end
