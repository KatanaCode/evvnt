# evvnt

[![CircleCI](https://circleci.com/gh/KatanaCode/evvnt.svg?style=svg)](https://circleci.com/gh/KatanaCode/evvnt)

Provides a Ruby wrapper around the evvnt APIs

---

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'evvnt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install evvnt

## Usage

Before you begin, you'll need to obtain an API key and secret from evvnt. Once you have that in place, include these in your gem configuration.

### Configuration

To configure the gem, create an initializer and define the following block:

``` ruby
# config/initializers/evvnt.rb
Evvnt.configure do |config|
  # Print out useful logger info to the Rails log
  config.logger     = Rails.logger
  config.debug      = Rails.env.development?
  # Your API key and secret
  config.api_key    = "..."
  config.api_secret = "secret"
end

```

### In your code

This gem provides an equivalent endpoint for each of the endpoints on the evvnt API. It follows a familiar, idomatic rails pattern to create, fetch, and, update records.

For example:

```ruby
# => Returns all of the categories from the API as an Evvnt::Category object
@categories = Evvnt::Category.all

# The same as the above, aliased
@categories = Evvnt::Category.index

# Returns the first Category
@category = Evvnt::Category.first
@category.name # => "Academic / Learning"

# Returns the last Category
@category = Evvnt::Category.last
@category.name # => "Alternative Investment"

# Create a User on the API
@user = Evvnt::User.create(name: "Sarah Connor", email: "sarah@example.com")

# Grab the last User from the API and update their email address:
@user = Evvnt::User.last
@user.email = "newemail@example.com"
@user.save
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/katanacode/evvnt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
