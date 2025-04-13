class AddressesController < ApplicationController
  include FetchWeatherService
  protect_from_forgery with: :null_session

  # TODO: Clean up this method. Make it easier to read and extract logic to other methods or services
  def fetch_address_forcast
    postal_code = params[:postalCode]
    latitude = params[:latitude]
    longitude = params[:longitude]
    @address = Address.find_by(postal_code: postal_code)

    if @address
      if !@address.last_api_call || @address.need_to_cache
        lat = params[:address][:lat]
        lon = params[:address][:lon]
        new_forecast = FetchWeatherService::fetch_forecast(latitude, longitude)        
        if new_forecast
          @address.update(last_api_call: Time.now, forecast: new_forecast)
          render json: { success: true, data: @address, message: "called api for exsisting addresss", address: params }, status: :ok
        else
          render json: { success: false, error: 'Unable to fetch weather data' }, status: :unprocessable_entity
        end
      else
        render json: { success: true, data: @address, cached: true, message: "cached response", address: params }, status: :ok
      end
    else
      new_forecast = FetchWeatherService::fetch_forecast(latitude, longitude)
      if new_forecast
        @address = Address.create(last_api_call: Time.now, postal_code: postal_code, forecast: new_forecast)
        render json: { success: true, data: @address, message: "Brand new forecaset for new address", address: params }, status: :created
      else
        render json: { success: false, error: 'Unable to fetch weather data' }, status: :unprocessable_entity
      end
    end
  end
end