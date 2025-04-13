class Address < ActiveRecord::Base
  validates :postal_code, presence: true, length: { minimum: 4, maximum: 12 }, uniqueness: true

  def need_to_cache
    self.last_api_call.nil? || self.last_api_call < 30.minutes.ago
  end

end
