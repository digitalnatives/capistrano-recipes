set_default(:unicorn_user)          { user }
set_default(:unicorn_pid)           { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:shared_unicorn_config) { "#{shared_path}/config/unicorn.rb" }
set_default(:unicorn_config)        { "#{current_path}/unicorn.conf" }
set_default(:unicorn_log)           { "#{shared_path}/log/unicorn.log" }
set_default(:unicorn_port)          { abort 'You must set unicorn port' }
set_default :unicorn_workers, 2
set_default :unicorn_timeout, 60

namespace :unicorn do

  desc "Setup Unicorn app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{File.dirname shared_unicorn_config}"
    template "unicorn.rb.erb", shared_unicorn_config
  end
  after "deploy:setup", "unicorn:setup"

  desc 'Links the unicorn config into the application root'
  task :link_config, roles: :app do
    run "ln -snf #{shared_unicorn_config} #{unicorn_config}"
  end
  after "deploy:create_symlink", "unicorn:link_config"

  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command, roles: :app do
      run "cd #{current_path}; rubyapp-manager #{command} #{application}-#{rails_env}"
    end
    after "deploy:#{command}", "unicorn:#{command}"
  end

  after 'deploy:start',   'unicorn:start'
  after 'deploy:stop',    'unicorn:stop'
  after 'deploy:restart', 'unicorn:restart'

end
