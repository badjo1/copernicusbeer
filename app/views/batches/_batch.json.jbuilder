json.extract! batch, :id, :serialnumber, :description, :liters, :created_at, :updated_at
json.url batch_url(batch, format: :json)
