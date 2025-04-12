module DateFormatConcern
  extend ActiveSupport::Concern
    class << self
      def month_day(timestamp)
        date = Time.at(timestamp).to_date
        formatted_date = date.strftime('%b %d')
        day_with_suffix(formatted_date, date.day)
      end
  
    def day_with_suffix(formatted_date, day)
      suffix = case day
                when 1, 21, 31 then 'st'
                when 2, 22 then 'nd'
                when 3, 23 then 'rd'
                else 'th'
                end
      formatted_date.sub(/\d{2}/, "#{day}#{suffix}")
    end
  end
end