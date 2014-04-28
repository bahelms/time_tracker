class Project < ActiveRecord::Base
  validates :name, :user_id, presence: true
  has_many :tasks
end
