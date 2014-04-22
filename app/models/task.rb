class Task < ActiveRecord::Base
  store_accessor :time, :start_time, :stop_time, :duration
  validates :user_id, presence: true
  default_scope { order(updated_at: :desc) }
  belongs_to :project
end
