require 'rails_helper'

RSpec.describe "Address API", type: :request do

  describe 'POST /addresses/fetch' do
    it 'returns an address if already created' do
      test_lat = '35.6895'
      test_lon = '139.6917'
      address = Address.create(postal_code: '12345', last_api_call: Time.now)
      post '/addresses/fetch', params: { postalCode: '12345', latitude: test_lat, longitude: test_lon }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response["data"]["postal_code"]).to eq('12345')
    end

    it "does not fetch new forecast if last API call was within 30 minutes" do
      test_lat = '35.6895'
      test_lon = '139.6917'
      address = Address.create(postal_code: '12345', last_api_call: 10.minutes.ago, forecast: { temp: 20 })
      post '/addresses/fetch', params: { postalCode: '12345', latitude: test_lat, longitude: test_lon }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response["cached"]).to eq(true)
      expect(json_response["data"]["forecast"]["temp"]).to eq(20)
    end

    it 'fetches new forecast if last API call was more than 30 minutes ago' do
      test_lat = '35.6895'
      test_lon = '139.6917'
      address = Address.create(postal_code: '12345', last_api_call: 40.minutes.ago, forecast: { temp: 20 })
      post '/addresses/fetch', params: { postalCode: '12345', latitude: test_lat, longitude: test_lon }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json_response["cached"]).to eq(nil)
      expect(json_response["data"]["forecast"]["temp"]).not_to eq(20)
    end

    it 'creates a new address if not found' do
      test_lat = '35.6895'
      test_lon = '139.6917'
      post '/addresses/fetch', params: { postalCode: '54321', latitude: test_lat, longitude: test_lon }, as: :json
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(Address.count).to eq(1)
    end
  end
end