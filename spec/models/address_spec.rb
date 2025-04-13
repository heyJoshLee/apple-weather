require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'custom methods' do
    describe '#need_to_cache' do
      it 'returns true if last_api_call is nil' do
        address = Address.new(last_api_call: nil)
        expect(address.need_to_cache).to eq(true)
      end

      it 'returns true if last_api_call is older than 30 minutes' do
        address = Address.new(last_api_call: 31.minutes.ago)
        expect(address.need_to_cache).to eq(true)
      end
      it 'returns false if last_api_call is within the last 30 minutes' do
        address = Address.new(last_api_call: 10.minutes.ago)
        expect(address.need_to_cache).to eq(false)
      end
    
    end
  end

end