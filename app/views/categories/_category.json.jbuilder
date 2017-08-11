json.extract! category, :id, :title, :desc, :slugged, :created_at, :updated_at
json.url category_url(category, format: :json)
