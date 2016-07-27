# ServiceCall

Adds a little niceness to callable service objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'service_call'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install service_call

## Usage

Define a class that includes `ServiceCall` and implements the `call` method:

```ruby
class MyService
  include ServiceCall

  def call(message)
    puts "MyService is #{message}"
  end
end
```

Then you can instantiate your class and invoke `call` using any of these methods:

```ruby
MyService.new.call("useful")
MyService.call("useful")
MyService.new.("useful")
MyService.("useful")
```

If you define any `attr_reader` methods, `ServiceCall` will automatically pass any named parameters to your initializer.

```ruby
class ServiceWithAttributes
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def call
    puts name
  end
end

ServiceWithAttributes.(name: "George") # => "George"

Additionally, you can define collaborators with default values using `attribute`.

```ruby
class ServiceWithDefaults
  include ServiceCall

  attribute :other_service, default: OtherService

  def call
    puts "other_service is a #{other_service.class}"
    # If OtherService is a ServiceCall, you can invoke it like:
    other_service.()
  end
end

ServiceWithDefaults.() # => "other_service is a OtherService"
ServiceWithDefaults.new(other_service: MockService).() # => "other_service is a MockService"
```

Defining dependent services this way makes it easy to mock them with lambdas during testing, override them at run time, and "just use them" without complicated initialization or factory methods.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/emfeng/service_call.

