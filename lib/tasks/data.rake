namespace :data do

  desc "Collect datapoint for all watches"
  def collect
    Watch.find_each do |watch|
      watch.tick
    end
  end
end