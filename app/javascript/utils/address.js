export const createAddress = async (address, weather) => {
  console.log("Creating address with weather data:", address, weather);
  const response = await fetch('/addresses/', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      address,
      weather
    })
  });

  const data = await response.json();
  return data; 
}


export const fetchAddress = async (address) => {
  const response = await fetch(`/addresses/fetch`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(address)
  });
  console.log("js file fetchAddress response:", response);
  const data = await response.json();
  return data; 
}