set_default(:thin_pid)           { "#{current_path}/tmp/pids/thin.pid" }
set_default(:shared_thin_config) { "#{shared_path}/config/thin.yml" }
set_default(:thin_config)        { "#{current_path}/thin.yml" }
set_default(:thin_log)           { "#{shared_path}/log/thin.log" }
set_default(:thin_port)          { abort 'You must set thin port' }
set_default :thin_workers, 2
set_default :thin_timeout, 30
set_default :thin_wait, 30
set_default :thin_max_conns, 1024
set_default :thin_max_persistent_conns, 512
set_default :thin_server, 2
set_default :thin_demonize, true

namespace :thin do

  desc "Setup thin app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{File.dirname shared_thin_config}"
    template "thin.yml.erb", shared_thin_config
  end
  after "deploy:setup", "thin:setup"

  desc 'Links the thin config into the application root'
  task :link_config, roles: :app do
    run "ln -snf #{shared_thin_config} #{thin_config}"
  end
  after "deploy:create_symlink", "thin:link_config"

  %w[start stop restart].each do |command|
    desc "#{command} thin"
    task command, roles: :app do
      run "cd #{current_path}; rubyapp-manager #{command} #{application}-#{rails_env}"
    end
    after "deploy:#{command}", "thin:#{command}"
  end

  after 'deploy:start',   'thin:start'
  after 'deploy:stop',    'thin:stop'
  after 'deploy:restart', 'thin:restart'

end
