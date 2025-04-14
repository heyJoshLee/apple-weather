# Weather app
Application to get weather forecast for a specific address. Includes test suite.

Author: Josh Lee

 

## Walkthrough Video
[Video Link](https://komododecks.com/recordings/0UGW9ZHbgYZ1gMpkShtr)

## Deployment

### Live Application
[Live Link](https://apple-weather-e275e6d6cd35.herokuapp.com/)

### Local
1. Pull the code
2. Install dependencies
3. Set API credentials in config/credentials.yml
  ```ymal
    weather:
      base_url: https://api.openweathermap.org/data/2.5/
      api_key: API_KEY
    address:
      api_key: API_KEY
    secret_key_base: KEY
  ```
  4. Migrate database

### Test suite
$ rspec


## FetchWeatherService
Interface with the third-party weather API. Can later be refactored to decouple the third-party API from the rails service.

#### Methods
  - fetch_forecast(String, String): Returns multiple forecasts for the current day
  - fetch_current_weather(String, String): Returns single weather data point. Not used.

## Address
  validates :postal_code, presence: true, length: { minimum: 4, maximum: 12 }, uniqueness: true


#### Attributes
- postal_code: Required, unique, between 4 and 12 chars

#### Methods
- need_to_cache(): Returns bool if current TimeDate is longer than 30.mins.ago (this is set in the model file)




