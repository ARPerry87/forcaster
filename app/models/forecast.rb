# app/models/forecast.rb
class Forecast
  CACHE_EXPIRATION = 30.minutes

  attr_reader :current_temperature, :high, :low, :extended_forecast, :from_cache

  def initialize(attributes)
    @current_temperature = attributes[:current_temperature]
    @high = attributes[:high]
    @low = attributes[:low]
    @extended_forecast = attributes[:extended_forecast]
    @from_cache = attributes[:from_cache]
  end

  def self.for_address(address)
    Rails.cache.fetch("forecast-#{address}", expires_in: CACHE_EXPIRATION) do
      # Retrieve the forecast data from a weather API or other source
      forecast_data = retrieve_forecast_data(address)

      # Create a Forecast object with the retrieved data
      new(
        current_temperature: forecast_data[:current_temperature],
        high: forecast_data[:high],
        low: forecast_data[:low],
        extended_forecast: forecast_data[:extended_forecast],
        from_cache: false
      )
    end
  end

  private

  def self.retrieve_forecast_data(address)
    geocode = GeocodeService.call(address)
    weather = WeatherService.call(geocode.latitude, geocode.longitude)

    {
      current_temperature: weather.temperature,
      high: weather.temperature_max,
      low: weather.temperature_min,
      extended_forecast: generate_extended_forecast(weather)
    }
  end

  def self.generate_extended_forecast(weather)
    # Generate an extended forecast based on the current weather data
    # This could involve additional API calls or calculations
    # For simplicity, we'll just return a placeholder string
    "Extended forecast for the week: #{weather.description}"
  end
end
