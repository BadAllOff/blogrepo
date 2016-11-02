json.array!(@articles) do |article|
  json.extract! article, :id, :title, :content, :pub_date
  json.url article_url(article, format: :json)
end
