class UpcomingHolidaysFacade
  def self.find_holidays
    json = UpcomingHolidaysService.search_holidays
    holidays = json.map do | data |
      UpcomingHolidays.new(data)
    end
  end
end
