module Evvnt
  # Internal: Methods for defining API actions for each resource Class.
  #
  module Actions

    ##
    # The first record from the API index actions
    #
    # Returns {Evvnt::Base} subclass
    def first
      defined_actions.include?(:index) ? all.first : method_missing(:first)
    end

    ##
    # The last record from the API index actions
    #
    # Returns {Evvnt::Base} subclass
    def last
      defined_actions.include?(:index) ? all.first : method_missing(:last)
    end

    private

      ##
      # A list of the API actions defined on this class
      #
      # Returns Array
      def defined_actions
        @defined_actions ||= []
      end

      ##
      # Define an action for this class to map on to the Evvnt API for this class's
      # resource.
      #
      # action - A Symbol or String representing the action name. Should be one of the
      #          template actions if block is not provided.
      # block  - A Proc to be used as the action method definition when custom behaviour
      #          is required.
      #
      # Examples
      #
      #   class Package < Evvnt::Base
      #     # Define using the template `all` method
      #     define_action :all
      #     define_action :mine do
      #       # define the custom behaviour here
      #     end
      #   end
      #
      # Returns Symbol
      def define_action(action, &block)
        action = action.to_sym
        defined_actions << action unless defined_actions.include?(action)
        if action.in?(Evvnt::ClassTemplateMethods.instance_methods)
          define_class_action(action, &block)
        end
        if action.in?(Evvnt::InstanceTemplateMethods.instance_methods)
          define_instance_action(action, &block)
        end
        action
      end

      # Define a class-level action on the current class. See {define_action}.
      def define_class_action(action, &block)
        body = block_given? ? block : ClassTemplateMethods.instance_method(action)
        define_singleton_method(action, body)
        singleton_class.send(:alias_method, :all, :index) if action == :index
        singleton_class.send(:alias_method, :find, :show) if action == :show
      end

      # Define an instance-level action on the current class. See {define_action}.
      def define_instance_action(action, &block)
        body = block_given? ? block : InstanceTemplateMethods.instance_method(action)
        define_method(action, body)
      end

  end
end
