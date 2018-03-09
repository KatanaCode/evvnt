module StubApiRequestHelper
  class MissingFixtureError < StandardError
  end

  REQUEST_HEADERS = {
    'Accept'        =>'application/json',
    'Authorization' =>'Basic a2F0YW5hOnNlY3JldA==',
    'Content-Type'  =>'application/json'
  }.freeze

  def stub_api_request(verb, path, options = {})
    file_name = options.delete(:fixture) || "#{verb}-#{path}"
    file_path = File.join("spec", "fixtures", "responses", "#{file_name}.json")
    unless File.exist?(file_path)
      raise MissingFixtureError,
            "#{file_name} not found. Did you forget to create #{file_path}"
    end
    body_file = File.read(file_path)
    body_json = JSON.parse(body_file)
    code      = verb == :post ? 201 : 200
    stub_request(verb, "https://api.sandbox.evvnt.com/#{path}.json").
      with(headers: REQUEST_HEADERS, query: options[:params]).
      to_return(status: code, body: body_file, headers: {})
  end

end