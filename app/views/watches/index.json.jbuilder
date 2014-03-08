json.array!(@watches) do |watch|
  json.extract! watch, :id, :name
  json.url watch_url(watch, format: :json)
end
