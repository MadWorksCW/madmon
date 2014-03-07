class PingWatch < Watch

  def self.configuration_options
    [:host]
  end

  def tick
    self.datapoints.create(value: PingWatch.parse_ping_to_ms(ping_output))
  end

  def ping_output
    `ping -c1 #{config[:host]}`
  end

  def self.parse_ping_to_ms(ping_output)
    matches = ping_output.match(/time=(\d+\.?\d+)/)
    matches[1].to_f
  end
end