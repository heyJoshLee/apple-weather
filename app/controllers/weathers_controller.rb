class WeathersController < ApplicationController
  include FetchWeatherService

  protect_from_forgery with: :null_session

  # API call format
  # https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

  def now
    lat = params[:lat]
    lon = params[:lon]
    response = FetchWeatherService::fetch_current_weather(lat, lon)
    if response
      render json: response, status: :ok
    else
      render json: { error: 'Unable to fetch weather data' }, status: :unprocessable_entity
    end
  end

  def forecast
    lat = params[:lat]
    lon = params[:lon]
    response = FetchWeatherService::fetch_forecast(lat, lon)
    if response
      render json: response, status: :ok
    else
      render json: { error: 'Unable to fetch forecast data' }, status: :unprocessable_entity
    end
  end

end