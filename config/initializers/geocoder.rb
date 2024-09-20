Geocoder.configure(
  http_headers: { "Accept-Encoding" => "json" },
  # geocoding service request timeout, in seconds (default 3):
  esri: {
    api_key: [
      Rails.application.credentials[:api_key]
    ],
    for_storage: true
  }
)
