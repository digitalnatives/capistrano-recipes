require 'capistrano'
require 'capistrano/recipes/version'

cap = Capistrano::Configuration.instance(true)
cap.load 'capistrano/recipes/base'
cap.load 'capistrano/recipes/logs'

# cap.load 'capistrano/recipes/assets'
# cap.load 'capistrano/recipes/database'
# cap.load 'capistrano/recipes/rvm'
# cap.load 'capistrano/recipes/subdirectory'
# cap.load 'capistrano/recipes/unicorn'

