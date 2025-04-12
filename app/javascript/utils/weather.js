// Calls the Rails method to get data from the API and then passes is to view
export const getCurrentWeatherFromRailsAPI = async (address) => {
  const { latitude: lat, longitude: lon } = address;
  console.log("Getting weather for location:", lat, lon);
  const response = await fetch('/weather/now', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ lat, lon })
  });

  const data = await response.json();
  return data; 
}

export const getWeatherForecastFromRailsAPI = async (address) => {
  const { latitude: lat, longitude: lon } = address;
  console.log("Getting weather forecast for location:", lat, lon);
  const response = await fetch('/weather/forecast', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ lat, lon })
  });

  const data = await response.json();
  return data; 
}

export const toCelsius = (kelvin) => {
  const value = kelvin - 273.15;
  return `${value.toFixed(2)}°C`;
}

export const toFahrenheit = (kelvin) => {
  const value = ((kelvin - 273.15) * 9/5) + 32
  return `${value.toFixed(2)}°F`;
}