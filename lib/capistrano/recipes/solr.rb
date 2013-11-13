namespace :solr do

  desc "Start solr instance for this application"
  task :start do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:start"
  end

  desc "Stop solr instance for this application"
  task :stop do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:stop" rescue nil
  end

  desc "Restart solr instance for this application"
  task :restart, roles: :app do
    stop
    start
  end

  after 'deploy:start',   'solr:start'
  after 'deploy:stop',    'solr:stop'
  after 'deploy:restart', 'solr:restart'

end
