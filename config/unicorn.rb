application = 'item-management'

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
working_directory "/data/item-management/current/"

listen "/data/item-management/current/tmp/pids/unicorn.sock"

pid "/data/item-management/current/tmp/pids/unicorn.pid"

timeout 60

preload_app true

stdout_path "/data/item-management/current/log/unicorn.stdout.log"
stderr_path "/data/item-management/current/log/unicorn.stderr.log"

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
