# Midas

> Everything I touch turns to gold!

Midas provides a collection of classes to help manage inputs. The concept is
simple. You have a collection of inputs. Those inputs can each have multiple
filters as well as multiple validation rules.

If you choose you can filter and validate the individual inputs or do them all
together in a group.

**Midas provides no pre-created validation or filter rules. I believe everyone
should understand the exact way their validations and filters work.**

## Installation

Add this line to your application's Gemfile:

    gem 'midas'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install midas

## Usage

### Sinatra DSL

#### Classic

    require "sinatra"
    require "midas"

    post("foo") do
      form do
        filters :strip
        field :first_name, :required
        field :last_name,  :required
        field :contact,    :phone_number
      end

      if form.valid?
        # do something
      else
        # render the form
      end
    end

    # in foo.html.erb
    <% if form.error_on?(:first_name) %>
      First name is required
    <% end %>
    <input name="first_name" value="<%= form[:first_name] %>" >

#### Modular

    require "sinatra/base"
    require "midas"

    class Application < Sinatra::Base
      helpers Sinatra::Midas
    end


#### Creating filters

    class StripFilter < Midas::Filter
      def call(value)
        value.respond_to?(:strip) ? value.strip : value
      end
    end

    # Register filter for Sinatra DSL
    Midas.register_filter(StripFilter.new(:strip))

#### Creating validators

    class PositiveNumberValidator < Midas::Validation
      def call(value)
        value.to_f > 0
      end
    end

    # Register validation for Sinatra DSL
    Midas.register_validation(PositiveNumberValidator.new(:positive))

#### Using inputs

    first_name = Midas::Input.new(:first_name)
    first_name.filters << Midas.find_filter(:strip)
    first_name.validations << Midas.find_validator(:positive)
    first_name.value = " Darren Coxall "

    # filter
    first_name.filter! # => "Darren Coxall"

    # validate
    first_name.valid? # => false

#### Using groups

    form = Midas::InputGroup.new
    form.inputs << first_name # first_name is Midas::Input instance

    # form wide filtering
    form.filters << Midas.find_filter(:strip)
    form.filter!

    # validation
    form.valid? # => false

#### Accessing values

    # form = Midas::InputGroup.new
    form[:first_name] # => "Darren Coxall"
    form[:unknown]    # => nil

    # Finding the input object
    form.input(:first_name) # => Midas::Input

## Contributing

All contributions should be tested using Cucumber. To run the test suite do the
following:

    $ bundle install
    $ bundle exec rake
