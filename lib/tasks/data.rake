namespace :data do

  desc "Collect a single datapoint for all watches"
  task :tick => [:environment] do
    Watch.find_each do |watch|
      watch.tick
    end
  end

  desc "Start a process that collects a datapoint every few seconds"
  task :collect => [:environment] do
    threads = []
    Watch.find_each do |watch|
      threads << run(watch)
    end
    threads.each(&:join)
  end

  def run(watch)
    t = Thread.new do
      puts "Starting watch for #{watch.name}"
      loop { print "."; watch.tick; sleep watch.frequency  }
    end
    t
  end
end
