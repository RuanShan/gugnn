json.extract! pet, :id, :title, :desc, :slugged, :owner_id, :price, :created_at, :updated_at
json.url pet_url(pet, format: :json)
