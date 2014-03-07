namespace :db do
  namespace :seed do
    task :random => :environment do
      watch = RandomWatch.create
      current = Datapoint.last ? Datapoint.last.created_at : Time.now

      num = ENV['NUM'].to_i || 20
      num.times do |index|
        watch.tick
        datapoint = Datapoint.last
        datapoint.created_at = current + index * 1.minute
        datapoint.save
        puts "Datapoint #{datapoint.id} created"
      end
    end
  end
end
