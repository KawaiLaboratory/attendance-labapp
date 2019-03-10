class Log < ApplicationRecord
  belongs_to :member
  
  validates :total_time, presence: true
  validates :status,     presence: true
  
  attribute :total_time, :integer, default: -> { 0 }
  
  enum status: Member.statuses
end
