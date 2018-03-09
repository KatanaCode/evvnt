module Evvnt
  # Provides methods for saving an individual record to the API
  module Persistence
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

    private

    # Save this record to the EVVNT API as a new record using the +create+ action.
    #
    def save_as_new_record
      new_attributes = attributes.reject { |k, _v| k.to_s =~ /^(id|uuid)$/ }
      self.class.create(new_attributes)
    end

    # Save this record to the EVVNT API as an existing record using the +update+ action.
    #
    def save_as_persisted_record
      new_attributes = attributes.reject { |k, _v| k.to_s =~ /^(id|uuid)$/ }
      self.class.update(id, new_attributes)
    end
  end
end
