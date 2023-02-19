json.extract! qrcode, :id, :code, :baseurl, :created_at, :updated_at
json.url labelcode_url(qrcode, format: :json)
