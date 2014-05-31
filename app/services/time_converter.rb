class TimeConverter
  attr_reader :time_string, :period, :date

  def initialize(time_string, period=nil, date=nil)
    @time_string = time_string
    @period = period
    @date = date
  end

  def convert
    hours, mins, secs = time_string.split(":").map(&:to_i)
    hours += 12 if period == "PM"
    create_time_object(hours, mins, secs)
  end

  private
    def create_time_object(hours, mins, secs)
      if date
        Time.new(date.year, date.month, date.day, hours, mins, secs)
      else
        Time.new(0, nil, nil, hours, mins, secs)
      end
    end
end
