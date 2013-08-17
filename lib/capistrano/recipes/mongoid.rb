namespace :database do

  desc 'Links the database config'
  task :link_config, roles: :app do
    link_shared_config 'mongoid.yml'
  end
  after "deploy:finalize_update", "database:link_config"

end
