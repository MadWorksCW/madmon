json.datapoints @datapoints do |datapoint|
  json.value datapoint.value
  json.time datapoint.created_at
end
