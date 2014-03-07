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
      puts "Starting watch for #{watch.name}"
      threads << Thread.new { loop { watch.tick; sleep watch.frequency; print "." } }
    end 
    threads.each(&:join)
  end
end