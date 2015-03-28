json.array!(@ups) do |up|
  json.extract! up, :id, :name
  json.url up_url(up, format: :json)
end
