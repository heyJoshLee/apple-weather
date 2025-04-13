// Calls the Rails method to get data from the API and then passes is to view
export const getCurrentWeatherFromRailsAPI = async (address) => {
  const { latitude: lat, longitude: lon, postalCode } = address;
  const response = await fetch('/weather/now', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ lat, lon, postal_code: postalCode })
  });

  const data = await response.json();
  return data; 
}

export const getWeatherForecastFromRailsAPI = async (address) => {
  const { latitude: lat, longitude: lon, postalCode } = address;
  const response = await fetch('/weather/forecast', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ lat, lon, postal_code: postalCode })
  });

  const data = await response.json();
  return data; 
}

export const getAddressFromRailsAPI = async (postalCode) => {
  const response = await fetch(`/addresses/${postalCode}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    },
  });

  const data = await response.json();
  return data; 
}

export const updateAddressInRailsAPI = async (address, weather) => {
  const response = await fetch(`/addresses/${address.postalCode}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(address),
    address: JSON.stringify(weather)

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

export const timeFromDateTime = (dateTime) => {
  return dateTime.split(" ")[1];
}

export const prettyDatefromYYYMMDD = (dateString) => {
  const date = new Date(dateString);

  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  const formatted = date.toLocaleDateString('en-US', options);

  const day = date.getDate();
  const suffix = getOrdinalSuffix(day);

  return formatted.replace(day.toString(), `${day}${suffix}`);
}

function getOrdinalSuffix(day) {
  if (day >= 11 && day <= 13) return 'th';

  const lastDigit = day % 10;
  switch (lastDigit) {
    case 1: return 'st';
    case 2: return 'nd';
    case 3: return 'rd';
    default: return 'th';
  }
}