# Internal: Template methods to provide default behaviour for API actions.
#
# These are defined on Evvnt::Base subclasses where required to map the Evvnt API
# actions.
module Evvnt::InstanceTemplateMethods

  # Template method for updating a given record
  #
  # record_id - An Integer or String representing the record ID on the API.
  # params    - A Hash of params to send to the API.
  #
  # Returns {Evvnt::Base} subclass
  def update(**new_attributes)
    self.class.update(id, new_attributes) unless new_attributes == attributes
  end
end
