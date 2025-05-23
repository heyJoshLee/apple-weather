import { Controller } from "@hotwired/stimulus";
import { init } from "address_api";
import { fetchAddress } from "addressjs";
import { timeFromDateTime, prettyDatefromYYYMMDD } from "weatherjs";

export default class extends Controller {
  static targets = ['weatherCards', 'formattedAddress', 'mainDate', 'cachedText'];

  connect() {
    init(this.fetchWeatherForecastForLocation.bind(this));
  }

  // Currently using multi-date forecast instead of current weather
  async fetchWeatherForecastForLocation (address) {
    const weatherData = await fetchAddress(address);

    this.clearUi();

    const date = weatherData.data.forecast.list[0].dt_txt.split(" ")[0];    
    this.mainDateTarget.textContent = prettyDatefromYYYMMDD(date);
    const items = weatherData.data.forecast.list;

    const cachedText = weatherData.cached ? "Previously cached" : "Just now";
    this.cachedTextTarget.textContent = cachedText;

    // Render Weather Cards
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
    // TODO: Extract this to a partial or other template file
    card.innerHTML = `
      <div class="row">
        <p class="time">Time: ${timeFromDateTime(forecastData.dt_txt)}</p>
        <p class="temp">Temp: ${forecastData.main.temp}</p>
      </div>
      <div class="times row">
        <p class="temp min">Low: ${forecastData.main.temp_min}</p>
        <p class="temp max">High: ${forecastData.main.temp_max}</p>
      </div>

    `;
    return card;
  }

  // TOOD: Add this to an event listener to clear results when the user starts to enter a new address
  clearUi() {
    this.weatherCardsTarget.innerHTML = '';
    this.cachedTextTarget.textContent = '';
  }
}