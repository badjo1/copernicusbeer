json.extract! qrlink, :id, :url, :created_at, :updated_at
json.url qrlink_url(qrlink, format: :json)
