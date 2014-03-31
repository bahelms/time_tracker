class Task < ActiveRecord::Base
  store_accessor :time, :start_time, :stop_time, :duration
  validates :user_id, presence: true
end
