module TempFormatConcern
  extend ActiveSupport::Concern
    class << self

      # Convert Kelvin to Celsius
      def toCelsius(kelvin)
        value = (kelvin - 273.15).round(2)
        "#{value}°C"
      end

      # Convert Kelvin to Fahrenheit
      def toFahrenheit(kelvin)
        value = ((kelvin - 273.15) * 9/5 + 32).round(2)
        "#{value}°F"
      end
    end
end