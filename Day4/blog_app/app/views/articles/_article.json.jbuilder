json.extract! article, :id, :body, :img, :reports_count, :created_at, :updated_at
json.url article_url(article, format: :json)
