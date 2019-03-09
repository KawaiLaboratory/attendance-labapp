class Log < ApplicationRecord
  belongs_to :member
  
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
