require 'capistrano'
require 'capistrano/recipes/version'

Capistrano::Configuration.instance(true).load do
  load_paths << File.expand_path('../..', __FILE__)

  load 'capistrano/recipes/base'
  load 'capistrano/recipes/logs'

  # load 'capistrano/recipes/assets'
  # load 'capistrano/recipes/database'
  # load 'capistrano/recipes/rvm'
  # load 'capistrano/recipes/subdirectory'
  # load 'capistrano/recipes/unicorn'
end

