class Log < ApplicationRecord
  belongs_to :member
  
  validates :total_time, presence: true
  validates :status,     presence: true
  
  attribute :total_time, :integer, default: -> { 0 }
  
  enum status: {
    office:      0,
    experiment:  1,
    machining:   2,
    ogigaoka:    3,
    off_campus:  4,
    classwork:   5,
    cafeteria:   6,
    at_home:     7,
    late:        8,
    job_hunt:    9,
    absence:    10,
    homecaming: 11,
  }
end
