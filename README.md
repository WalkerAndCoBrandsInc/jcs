# IngramMicro
[![Build Status](https://travis-ci.org/WalkerAndCoBrandsInc/ingram_micro.svg?branch=master)](https://travis-ci.org/WalkerAndCoBrandsInc/ingram_micro)

[IngramMicro](http://www.ingrammicro.com/IMD_WASWeb/jsp/login/corporate.jsp) HTTPS XML API wrapper.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ingram_micro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ingram_micro

Next, you need to configure your defaults. In `lib/config`, create a
`defaults.yml` file, which should look something like this:

```
  :api_root: "api.com/path"
  :api_version: /vx.x/OtherInfo
  :content_type: content/xml
  :ca_path: /Path/To/Your/certs
```

## Usage

You could also configure `lib/ingram_micro/configuration.rb` directly
instead of loading a `defaults.yml` file.

```
  IngramMicro.configure do |config|
    config.api_root = "https://ingramurl.com"
    config.ca_file = '/path/to/your.crt'
    config.partner_name = 'account name'
    config.partner_password = 'password'
    config.source_url = 'https://www.example.com'
    config.debug = true
    config.logger = Rails.logger
  end
```

The `IngramMicro::Client` class creates the connection to the Brightpoint API
using the Faraday gem. The `Transmission` super class has subclasses (i.e. `SalesOrder`)
that correspond to different uses of the API.

These subclasses create XML files, tackling one element at a time. Hence the
`BaseElement` class and its subclasses for each element found in the forms. These
elements are designed to create XML elements that are empty or containing a
default value (hence the `DEFAULTS` hash constant) if no values are provided,
which is why the RSpec tests can create a new SalesOrder without providing any
information.

XML files are validated against the XSD schemas from the API docs and then
sent the request to the API.

More detailed instructions for use will be provided once we have tested and
calibrated this gem to work properly with the API.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ingram_micro. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
