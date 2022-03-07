class UpcomingHolidaysFacade
  def self.find_holidays(number)
    current_date = DateTime.now
    json = UpcomingHolidaysService.search_holidays
    holidays = []
    json.each do | data |
      holiday_date = DateTime.parse(data[:date])
      if current_date < holiday_date
        holidays << UpcomingHolidays.new(data)
      end
      if holidays.count == (number)
        break
      end
    end
    return holidays
  end
end
