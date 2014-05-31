class Task < ActiveRecord::Base
  store_accessor :time, :start_time, :stop_time, :duration
  validates :user_id, presence: true
  default_scope { order(created_at: :desc) }
  belongs_to :project

  def minutes
    duration.to_i / 60
  end

  def hours
    duration.to_i / 3600
  end
end
