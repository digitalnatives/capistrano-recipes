load 'deploy/assets'

namespace :deploy do
  namespace :assets do
    task :precompile, roles: :web, except: {no_release: true} do
      if should_precompile?
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        Capistrano::CLI.ui.say "Skipping asset pre-compilation because there were no asset changes"
      end
    end

    def should_precompile?
      from = source.next_revision(current_revision)
      capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
    rescue # No current/REVISION file
      return true
    end
  end
end

