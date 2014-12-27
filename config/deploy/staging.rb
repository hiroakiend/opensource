role :web, "54.149.83.123"                   # Your HTTP server, Apache/etc
role :app, "54.149.83.123"                   # This may be the same as your `Web` server
role :db,  "54.149.83.123", :primary => true # This is where Rails migrations will run

set :bundle_without, [:development, :test]
set :rails_env, 'production'


set :bundle_without, [:development, :test]
set :rails_env, 'production'

namespace :unicorn do
  desc 'Restart unicorn_rails.'
  task :restart, :roles => :web do
    run "#{try_sudo} su - unicorn -c 'cd #{current_path} && bundle exec rake unicorn:restart env=production port=8080'"
  end

  desc 'Start unicorn_rails.'
  task :start, :roles => :web do
    run "#{try_sudo} su - unicorn -c 'cd #{current_path} && bundle exec rake unicorn:start env=production port=8080'"
  end

  desc 'Stop unicorn_rails.'
  task :stop, :roles => :web do
    run "#{try_sudo} su - unicorn -c 'cd #{current_path} && bundle exec rake unicorn:stop env=production port=8080'"
  end
end
