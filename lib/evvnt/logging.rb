module Evvnt
  # Internal: Log messages for debugging
  #
  module Logging
    extend ActiveSupport::Concern

    ##
    # The tag to print to the logger.
    TAG_NAME = 'EVVNT'.freeze

    private

    # The Logger object to print out messages to.
    def logger
      Evvnt.configuration.logger
    end

    # Print a debug level message
    #
    # message - A String of the message to be printed.
    def debug(message)
      log_message(:debug, message)
    end

    # Log a message to the {logger} with the given log level
    #
    # level   - A Symbol representing the logger level
    # message - A String with the message to print to the log
    def log_message(level, message)
      if logger.respond_to?(:tagged)
        logger.tagged(TAG_NAME) { |l| l.public_send(level, message) }
      else
        logger.public_send(level, message)
      end
    end

    # rubocop:disable Naming/ConstantName
    # Make these methods available to the class when module is included.
    ClassMethods = self
    # rubocop:enable Naming/ConstantName
  end
end
