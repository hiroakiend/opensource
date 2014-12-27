require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, %w(development, staging, production)
set :default_stage, 'development'
set :application, "item-management"
set :scm, :git
set :repository, "git@github.com:hiroakiend/opensource.git"
set :branch, 'master'
set :deploy_to, '/data/item-management'
set :deploy_via, :copy
set :normalize_asset_timestamps, false
set :use_sudo, true
set :keep_releases, 3
set :default_environment, {
  'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

default_run_options[:pty] = true

after 'deploy:setup' do
  run "#{try_sudo} sh -c 'chown -R root:developers #{deploy_to}/'"
  run "#{try_sudo} sh -c 'chmod -R 775 #{deploy_to}/'"
end

after 'deploy' do
  run "#{try_sudo} sh -c 'chown -R :developers #{current_path}/'"
  run "#{try_sudo} sh -c 'chown -R :developers #{shared_path}/'"
  run "#{try_sudo} sh -c 'find #{current_path}/ -type d -print0 | xargs -0 chmod 775'"
  run "#{try_sudo} sh -c 'find #{current_path}/ -type f -print0 | xargs -0 chmod 664'"
  run "#{try_sudo} sh -c 'find #{shared_path}/ -type d -print0 | xargs -0 chmod 775'"
  run "#{try_sudo} sh -c 'find #{shared_path}/ -type f -print0 | xargs -0 chmod 664'"

  run "#{try_sudo} sh -c 'chmod 777 -R #{current_path}/tmp/'"
  run "#{try_sudo} sh -c 'chmod 775 -R #{current_path}/bin/'"
  run "#{try_sudo} sh -c 'chmod 755 -R #{shared_path}/bundle/'"
  run "#{try_sudo} sh -c 'chmod 777 -R #{shared_path}/log/'"
  run "#{try_sudo} sh -c 'chmod 777 -R #{shared_path}/pids/'"
  run "#{try_sudo} sh -c 'chmod 777 -R #{shared_path}/system/'"
end

after 'deploy:update', 'deploy:cleanup'
