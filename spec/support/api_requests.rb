RSpec.configure do |config|
  config.before(:all, type: :api) do
    config.include StubApiRequestHelper

    Evvnt.configure do |config|
      dir_path = File.join(File.dirname(__FILE__), "..", "..", "log")
      log_path = File.join(dir_path, "test.log")
      FileUtils.mkdir(dir_path) unless File.exist?(dir_path)
      FileUtils.touch(log_path) unless File.exist?(log_path)

      config.logger     = Logger.new(log_path)

      config.api_key    = "katana"
      config.api_secret = "secret"

      config.debug      = true
    end
  end
end