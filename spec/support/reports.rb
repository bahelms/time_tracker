def find_monthly_total_for_test
  extend TimePresenter
  secs = Task.where("updated_at >= ?", Time.current.localtime.beginning_of_month).
    map(&:duration).map(&:to_i).reduce(&:+)
  pretty_time(secs)
end
