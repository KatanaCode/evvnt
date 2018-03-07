module StubApiRequestHelper

  REQUEST_HEADERS = {
    'Accept'        =>'application/json',
    'Authorization' =>'Basic a2F0YW5hOnNlY3JldA==',
    'Content-Type'  =>'application/json'
  }.freeze

  def stub_api_request(verb, path, options = {})
    file_name = options.delete(:fixture) || "#{verb}-#{path}"
    body_file = File.read(File.join("spec", "fixtures", "responses", "#{file_name}.json"))
    body_json = JSON.parse(body_file)
    stub_request(:get, "https://api.sandbox.evvnt.com/#{path}.json").
      with(headers: REQUEST_HEADERS).
      to_return(status: 200, body: body_file, headers: {})
  end

end