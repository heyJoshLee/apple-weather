class AddressesController < ApplicationController
  include FetchWeatherService
  protect_from_forgery with: :null_session

  # Consider refactoring to keep controllers thin
  def fetch_address_forecast
    postal_code = params[:postalCode]
    latitude = params[:latitude]
    longitude = params[:longitude]
    
    @address = Address.find_by(postal_code: postal_code)
  
    if @address
      handle_existing_address(@address, latitude, longitude)
    else
      handle_new_address(postal_code, latitude, longitude)
    end
  end
  
  private
  
  def handle_existing_address(address, latitude, longitude)
    if address_needs_update?(address)
      update_forecast(address, latitude, longitude)
    else
      render_json(address, cached: true, message: "cached response")
    end
  end
  
  def address_needs_update?(address)
    !address.last_api_call || address.need_to_cache
  end
  
  def update_forecast(address, latitude, longitude)
    new_forecast = FetchWeatherService.fetch_forecast(latitude, longitude)
    
    if new_forecast
      address.update(last_api_call: Time.now, forecast: new_forecast)
      render_json(address, message: "called api for existing address")
    else
      render_error('Unable to fetch weather data')
    end
  end
  
  def handle_new_address(postal_code, latitude, longitude)
    new_forecast = FetchWeatherService.fetch_forecast(latitude, longitude)
    
    if new_forecast
      @address = Address.create(last_api_call: Time.now, postal_code: postal_code, forecast: new_forecast)
      render_json(@address, message: "Brand new forecast for new address", status: :created)
    else
      render_error('Unable to fetch weather data')
    end
  end
  
  def render_json(address, message:, cached: false, status: :ok)
    render json: { success: true, data: address, cached: cached, message: message, address: params }, status: status
  end
  
  def render_error(message)
    render json: { success: nil, error: message }, status: :unprocessable_entity
  end
end