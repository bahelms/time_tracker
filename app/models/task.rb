class Task < ActiveRecord::Base
  store_accessor :time, :start_time, :stop_time
  validates :user_id, presence: true
  default_scope { order(created_at: :desc) }
  belongs_to :project

  def duration
    stop_time.to_i - start_time.to_i
  end

  def minutes
    duration.to_i / 60
  end

  def hours
    duration.to_i / 3600
  end
end
