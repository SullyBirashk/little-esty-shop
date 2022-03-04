class UpcomingHolidaysService
  def self.conn
    url = "https://date.nager.at"
    Faraday.new(url)
  end

  def self.search_holidays
    response = conn.get("/api/v1/Get/US/2022")
    JSON.parse(response.body, symbolize_names: true)
  end
end
