def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

def link_shared_config(file_name, to = nil)
  run "ln -snf #{shared_path}/config/#{file_name} #{release_path}/config/#{to || file_name}"
end

