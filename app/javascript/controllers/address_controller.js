import { Controller } from "@hotwired/stimulus";
import { init } from "address_api";
import { getCurrentWeatherFromRailsAPI, getWeatherForecastFromRailsAPI, toFahrenheit } from "weatherjs";

export default class extends Controller {
  static targets = ['weatherCards', 'formattedAddress'];

  connect() {
    init(this.fetchWeatherForecastForLocation.bind(this));
  }

  // Currently using multi-date forecast instead of current weather
  async fetchWeatherForecastForLocation (address) {
    this.formattedAddressTarget.textContent = address.formattedAddress;
    this.weatherCardsTarget.innerHTML = ''; // Clear previous cards
    const weatherData = await getWeatherForecastFromRailsAPI(address);
    console.log("Weather forecast data:", weatherData);
    // Handle displaying forecast data if needed

    const items = weatherData.list;

    const displayCount = 5;
    for (let i = 0; i <= displayCount; i++) {
      const forecast = items[i];
      const card = this.createCard(forecast);
      this.weatherCardsTarget.appendChild(card);
    }
  }

  // Creates the DOM element for a weather card
  createCard(forecastData) {
    const card = document.createElement('div');
    
    card.className = 'weather-card';
    card.innerHTML = `
      <h3 class="title">${forecastData.dt}</h3>
      <p class="temp">${forecastData.main.temp}</p>
      <div class="times">
        <ul class="min-max-temp">
          <p class="min-temp">${forecastData.main.temp_min}</p>
          <p class="max-temp">${forecastData.main.temp_max}</p>
        </ul>
      </div>

    `;
    return card;
  }


    // // Method to get current weather. Currently not being used
    // async fetchWeatherForLocation (address) {
    //   const weatherData = await getCurrentWeatherFromRailsAPI(address);
    //   console.log(address)
    //   console.log("Weather data:", weatherData);
    //   this.formattedAddressTarget.textContent = `Weather for ${address.formattedAddress}`;
    //   this.tempTarget.textContent = toFahrenheit(weatherData.main.temp);
    //   this.feelsTarget.textContent = `Feels Like: ${toFahrenheit(weatherData.main.feels_like)}`;
    //   this.minTarget.textContent = `Min Temperature: ${toFahrenheit(weatherData.main.temp_min)}`;
    //   this.maxTarget.textContent = `Max Temperature: ${toFahrenheit(weatherData.main.temp_max)}`;
    // }
  

  // // Rails endpoint to call API
  // async getWeatherFromAPI(address) {
  //   const { latitude: lat, longitude: lon } = address;
  //   console.log("Getting weather for location:", lat, lon);
  //   const response = await fetch('/weathers', {
  //     method: 'POST',
  //     headers: {
  //       'Content-Type': 'application/json'
  //     },
  //     body: JSON.stringify({ lat, lon })
  //   });

  //   const data = await response.json();
  //   return data; 
  // }

  // async getWeatherForLocation(address) {
  //   console.log("address:", address);
  //   const lat = address.latitude;
  //   const lon = address.longitude;
  //   console.log("Getting weather for location:", lat, lon);
  //   try {
  //     const weatherData = await fetchWeather(lat, lon);
  //     console.log("Weather data:", weatherData);
  //     this.displayWeather(weatherData);
  //   } catch (error) {
  //     console.log("There was an error getting the weather data")
  //   }
  // }

  // displayWeather(weatherData) {
  //   console.log("Displaying weather data:", weatherData);
  // }
}