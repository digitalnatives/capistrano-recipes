# Capistrano::Recipes

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-recipes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-recipes

## Usage

If you want to use the default recipes from this gem, you should put the
following line into your `Capfile`.
This will load the default

    require 'capistrano/recipes'

You can load any other recipe with the following lines

    load 'capistrano/recipes/assets'
    load 'capistrano/recipes/database'
    load 'capistrano/recipes/rvm'
    load 'capistrano/recipes/subdirectory'
    load 'capistrano/recipes/unicorn'

### Default recipes
#### Base - `capistrano/recipes/base.rb`
#### Logs - `capistrano/recipes/logs.rb`

### Optional recipes

#### Assets - `capistrano/recipes/assets`
#### Database configuration - `capistrano/recipes/database`
#### RVM - `capistrano/recipes/rvm`
#### Subdirectory deploy - `capistrano/recipes/subdirectory`
#### Unicorn - `capistrano/recipes/unicorn`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
