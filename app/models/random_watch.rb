require_dependency 'datapoint'
class RandomWatch < Watch
  MIN_MOD = 0.1
  MAX_MOD = 0.2

  after_initialize do
    @r = Random.new
  end

  def self.model_name
    Watch.model_name
  end


  def tick
    if self.datapoints.empty?
      random_value = 42
    else
      last_value = self.datapoints.last.value

      before_last_value = self.datapoints.all[self.datapoints.count-2].value
      mod = before_last_value > last_value ? 0.15 : -0.15

      modifier = @r.rand MIN_MOD..MAX_MOD
      if rand > (0.5 + mod)
        random_value = last_value + modifier*last_value
      else
        random_value = last_value - modifier*last_value
      end
    end
    self.datapoints.create(value: random_value)
  end

  def seed(number=20)
    number.times do 
      dp = tick
      dp.created_at = self.datapoints.last.created_at + 1.second
      dp.save
    end
  end
end
