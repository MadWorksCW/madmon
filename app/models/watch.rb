class Watch < ActiveRecord::Base
  has_many :datapoints
  serialize :config
  after_initialize do
    self.config ||= {}
  end

  def self.configuration_options
    []
  end

  # This should create a single datapoint somehow
  def tick
    raise NotImplementedError
  end

end
