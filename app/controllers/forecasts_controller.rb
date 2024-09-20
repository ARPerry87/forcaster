# app/controllers/forecast_controller.rb
class ForecastController < ApplicationController
  def show
    # Accept an address as input
    address = params[:address]

    # Retrieve forecast data for the given address
    forecast = Forecast.for_address(address)

    # Display the requested forecast details to the user
    render json: {
      current_temperature: forecast.current_temperature,
      high: forecast.high,
      low: forecast.low,
      extended_forecast: forecast.extended_forecast,
      from_cache: forecast.from_cache
    }
  end
end
