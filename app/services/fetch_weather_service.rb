require 'net/http'
require 'uri'
require 'json'
require_dependency 'date_format_concern'
require_dependency 'temp_format_concern'

module FetchWeatherService
  API_KEY = Rails.application.credentials.dig(:weather, :api_key)

  class << self
    def fetch_current_weather(lat, lon)
      base_url = 'https://api.openweathermap.org/data/2.5/weather?'
      url_string = "#{base_url}lat=#{lat}&lon=#{lon}&appid=#{API_KEY}"
      url = URI(url_string)
      begin
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request['Content-Type'] = 'application/json'
        response = http.request(request)
        data = response.body
        JSON.parse(data)
      rescue => error
        puts "Error fetching weather data: #{error}"
        return nil
      end
    end

    def fetch_forecast(lat, lon)
      base_url = 'https://api.openweathermap.org/data/2.5/forecast?'
      url_string = "#{base_url}lat=#{lat}&lon=#{lon}&appid=#{API_KEY}"
      url = URI(url_string)
      begin
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(url)
        request['Content-Type'] = 'application/json'
        response = http.request(request)
        data = response.body
        json_data = JSON.parse(data)
        # Format values to make them look nicer
        json_data["list"].map do |item|
          item["dt"] = DateFormatConcern.month_day(item["dt"])
          item["main"]["temp"] = TempFormatConcern.toFahrenheit(item["main"]["temp"])
          item["main"]["temp_min"] = TempFormatConcern.toFahrenheit(item["main"]["temp_min"])
          item["main"]["temp_max"] = TempFormatConcern.toFahrenheit(item["main"]["temp_max"])
          item["main"]["feels_like"] = TempFormatConcern.toFahrenheit(item["main"]["feels_like"])
        end
        json_data
      rescue => error
        return nil
      end
    end
  end
end