RSpec.configure do |config|
  config.before(:all, type: :api) do

    config.include RSpec::JsonMatchers::Matchers

    config.include StubApiRequestHelper

    Evvnt.configure do |config|
      config.api_key    = "katana"
      config.api_secret = "secret"
      unless File.exist?("./log/test.log")
        log_path = FileUtils.touch("./log/test.log")
      end
      config.logger     = Logger.new(log_path)
      config.debug      = true
    end
  end
end