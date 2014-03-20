# Jsoneur

A very simple, general purpose JSON API client to quickly consume (read) any sane JSON API. 
It is based on Faraday, provides a service registry for configuring multiple 
API endpoints and allows quick usage of these services.

Features:

* Path and query string parameters.
* No intermediate classes need to be setup.
* Simple endpoint setup and access on a configures service.
* Flexible processing of requests and responses through Faraday.
* Returns JSON as a Mash which means it can be accessed in a pseudo-object way and is nice for using it in  templates.


Limitations:

* Only get requests for now
* No splitting between query string and path parameters
* Probably many more ...


## Installation

Add this line to your application's Gemfile:

    gem 'jsoneur'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jsoneur

## Usage

A simple example

```ruby
require 'jsoneur'

# Configure Github API
Jsoneur.add('github_user_repos', 'https://api.github.com') do |service|
  service.path = '/users/%{user}/repos'
  
  # Define default parameters (default: {})
  # service.default_params = {search: 'search-term'}
  
  # Define the empty reponse in case nothing is found (default: [])
  # service.empty_response = {}

  # Setup your own Faraday Middleware stack
  # service.connection do |faraday|
  #   faraday.response :mashify
  #   faraday.response :xml,  :content_type => /\bxml$/
  #   # or set the Jsoneur defaults by calling
  #   set_faraday_defaults(faraday)
  # edd
end

# Configure another API, e.g. Twitter
Jsoneur.add('tweets', 'https://api.twitter.com') do |service|
  service.path = '/1.1/statuses/user_timeline.json'
  # ...
end


# Consume an API
repos = Jsoneur['github_user_repos'].get(user: 'geku')
repos.each do |r|
  puts "#{r.name} (#{r.owner.login})"
end

```

For a running example, see `examples/github.rb`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

MIT License. Copyright 2013 Georg Kunz, http://georgkunz.com