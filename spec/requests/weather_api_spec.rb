require 'rails_helper'

RSpec.describe "Weather API", type: :request do
  describe 'GET /weather/forecast' do
    it 'fetches current weather data' do
      test_lat = '35.6895'
      test_lon = '139.6917'
      post '/weather/forecast', params: { lat: test_lat, lon: test_lon }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response["list"]).to be_an(Array)
    end
    it "provides correct error response for invalid request" do
      post '/weather/forecast', params: { lat: 'invalid', lon: 'invalid' }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response["error"]).to eq('Unable to fetch forecast data')
    end
  end


end