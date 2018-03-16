# evvnt

Provides a Ruby wrapper around the evvnt APIs

[![Latest Version](https://img.shields.io/gem/v/evvnt.svg)](https://rubygems.org/gems/evvnt)
[![CircleCI](https://img.shields.io/circleci/project/github/KatanaCode/evvnt/master.svg)](https://circleci.com/gh/KatanaCode/evvnt)
[![Downloads](https://img.shields.io/github/downloads/katanacode/evvnt/total.svg)](https://img.shields.io/github/downloads/katanacode/evvnt/total.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/fdd8cffc25d6002a68df/maintainability)](https://codeclimate.com/github/KatanaCode/evvnt/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fdd8cffc25d6002a68df/test_coverage)](https://codeclimate.com/github/KatanaCode/evvnt/test_coverage)



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
  config.environment = Rails.env.production? ? :live : :sandbox
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

# Fetch one event from the API
@event = Evvnt::Event.find("....")

# The same as above, aliased
@event = Evvnt::Event.show("....")

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

## Documentation

For a full list of the Evvnt _model_ classes and their endpoints, please check out the documentation in the models, or in the [auto-generated docs](http://www.rubydoc.info/gems/evvnt/)

 - [Category](lib/evvnt/category.rb)
   - index (GET /categories List categories)
- [Contract](lib/evvnt/contract.rb)
  - index (GET /contract Get contract information)
- [Event](lib/evvnt/event.rb)
  - index (GET /events List Events)
  - create (POST /events  Create an event)
  - show (GET /events/:event_id Get one event)
  - update (PUT /events/:event_id  Update an event)
  - ours (GET /events/ours(/:id) Get events of you and your created users)
  - mine (GET /events/mine  List my events)
- [Package](lib/evvnt/package.rb)
  - index (GET /users/:user_id/packages Lists all of the packages belonging to a user)
  - create (POST /packages Create a package)
  - show (GET /packages/:package_id Get the details of a package)
  - mine (GET /packages/mine List my packages)
- [PublishedEvent](lib/evvnt/published_event,rb)
  - index (GET /events List Events)
  - show (GET /events/:event_id Get one event)
  - update (PUT /events/:event_id Update an event)
- [Publisher](lib/evvnt/publisher.rb)
  - index (GET /publishers List my publishing sites)
- [Report](lib/evvnt/report.rb)
  - show (/events/:event_id/report View report data for my event)
- [User](lib/evvnt/user.rb)
   - create (POST /users Create a user)
   - index (GET /users Get a list of all users created by you)
   - show (GET /users/:user_id Get details of a user)
   - update (PUT /users/:user_id Update a user)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/katanacode/evvnt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
