module TimePresenter
  FORTY_HOURS = 144000

  def pretty_time(seconds)
    hours = seconds / 3600
    mins  = seconds / 60 - hours * 60
    secs  = seconds % 60
    "#{digits(hours)}:#{digits(mins)}:#{digits(secs)}"
  end

  def digits(num)
    num < 10 ? "0#{num}" : num
  end
end
