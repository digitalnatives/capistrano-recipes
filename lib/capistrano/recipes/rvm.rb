namespace :rvm do
  desc 'Trust rvmrc file'
  task :trust_rc_file do
    run "rvm rvmrc trust #{current_path}"
  end

  desc 'Create rvmrc file'
  task :create_rvmrc do
    run "echo 'rvm use #{rvm_ruby_string}' > #{current_path}/.rvmrc"
  end
end

before 'deploy:setup',          'rvm:install_ruby'
after  'deploy:create_symlink', 'rvm:create_rvmrc'
after  'deploy:create_symlink', 'rvm:trust_rc_file'

require "rvm/capistrano"
