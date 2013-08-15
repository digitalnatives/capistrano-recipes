set_default(:subdirectory_path) { nil }

namespace :subdirectory do

  desc 'Creates a symlink to reach assets in subdirectory'
  task :link_assets_into_subdir, roles: :app do
    if subdirectory
      run "ln -snf #{release_path}/public #{release_path}/public/#{subdirectory_path}"
    end
  end

end
