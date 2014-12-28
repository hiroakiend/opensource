namespace :unicorn do

  PID_FILE_PATH = Rails.root.join('tmp', 'pids', 'unicorn.pid')

  desc 'Stop Unicorn'
  task :stop do
    begin
      master_pid = File.read(PID_FILE_PATH).to_i
      pids = %x[pgrep -P #{master_pid}].split
      puts 'Stopping Unicorn...'
      pids.each do |x|
        Process.kill 9, x.to_i
      end
      Process.kill 9, master_pid
      File.delete PID_FILE_PATH
      puts 'Unicorn stopped.'
    rescue Errno::ENOENT
      puts 'Unicorn doesn\'t seem to be running.'
    end
  end

  desc 'Start Unicorn'
  task :start do
    env = ENV['env'] || 'development'
    port = ENV['port'] || '8080'
    puts 'Starting Unicorn...'
    begin
      sh "unicorn_rails -E #{env} -c config/unicorn.rb -D"
      puts "Unicorn started under #{env} environment."
    rescue Exception => e
      puts e.backtrace
      File.delete PID_FILE_PATH if File.exists? PID_FILE_PATH
    end
  end

  desc 'Restart Unicorn'
  task :restart do
    Rake::Task['unicorn:stop'].invoke
    puts ''
    Rake::Task['unicorn:start'].invoke
  end

  desc 'Check Unicorn Status'
  task :status do
    begin
      master_pid = File.read(PID_FILE_PATH).to_i
      puts "Unicorn is running with pid #{master_pid}"
    rescue
      puts "Unicorn doesn't seem to be running."
    end
  end
end
