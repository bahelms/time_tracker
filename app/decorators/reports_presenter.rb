class ReportsPresenter
  include TimePresenter
  attr_reader :provider, :total_seconds_for_week

  def initialize(provider)
    @provider = provider
    @total_seconds_for_week = duration_sum
  end

  def weekly_total
    pretty_time(total_seconds_for_week)
  end

  def time_remaining_for_week
    pretty_time(FORTY_HOURS - total_seconds_for_week)
  end

  def monthly_total
    pretty_time()
  end

  private
    def duration_sum
      secs = provider.decorated_tasks.compact.map(&:duration).map(&:to_i).reduce(&:+)
      secs.nil? ? 0 : secs
    end
end
