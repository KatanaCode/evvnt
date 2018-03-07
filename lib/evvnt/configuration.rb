class Evvnt::Configuration

  ##
  #
  ENVIRONMENTS = %i[sandbox live].freeze


  ##
  #
  attr_writer :logger

  ##
  #
  attr_writer :debug

  ##
  #
  attr_accessor :api_key

  ##
  #
  attr_accessor :api_secret

  def initialize(&block)
    instance_eval(&block) if block_given?
  end

  ##
  #
  def environment=(value)
    raise ArgumentError unless value.to_sym.in?(ENVIRONMENTS)
    @environment = value
  end

  def environment
    @environment ||= :sandbox
  end

  ##
  #
  def logger
    @logger ||= Logger.new($stdout)
  end

  ##
  #
  def debug
    defined?(@debug) ? @debug : @debug = false
  end

end
