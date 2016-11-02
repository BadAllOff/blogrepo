json.array!(@books) do |book|
  json.extract! book, :id, :author, :title, :description, :draft
  json.url book_url(book, format: :json)
end
