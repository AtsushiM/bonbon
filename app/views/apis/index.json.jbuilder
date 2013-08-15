json.array!(@apis) do |api|
  json.extract! api, :name, :keyword
  json.url api_url(api, format: :json)
end
