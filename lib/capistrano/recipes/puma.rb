set_default(:puma_app_name)      { fetch(:application) }
set_default(:shared_puma_config) { "#{shared_path}/config/puma.rb" }
set_default(:puma_config)        { "#{current_path}/config/puma.rb" }

set_default :puma_workers, 2

namespace :puma do
  desc "Start puma instance for this application"
  task :start do
    run "/etc/init.d/puma start #{puma_app_name}"
  end

  desc "Stop puma instance for this application"
  task :stop do
    run "/etc/init.d/puma stop #{puma_app_name}"
  end

  desc "Restart puma instance for this application"
  task :restart, roles: :app do
    run "/etc/init.d/puma restart #{puma_app_name}"
  end

  desc "Show status of puma for this application"
  task :status, roles: :app do
    run "/etc/init.d/puma status #{puma_app_name}"
  end

  desc "Show status of puma for all applications"
  task :overview, roles: :app do
    run "/etc/init.d/puma status"
  end

  desc "Create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end

  desc 'Links the puma config into the application root'
  task :link_config, roles: :app do
    run "rm -f #{release_path}/config/puma.rb"
    run "ln -snf #{shared_puma_config} #{puma_config}"
  end

  desc "Setup puma app configuration"
  task :setup, roles: :app do
    run "mkdir -p #{File.dirname shared_puma_config}"
    template "puma.rb.erb", shared_puma_config
  end

  after 'deploy:setup',          'puma:setup'
  after 'deploy:create_symlink', 'puma:after_symlink'
  after "deploy:create_symlink", "puma:link_config"
  after 'deploy:start',          'puma:start'
  after 'deploy:stop',           'puma:stop'
  after 'deploy:restart',        'puma:restart'

end
