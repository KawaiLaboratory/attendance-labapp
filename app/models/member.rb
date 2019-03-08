class Member < ApplicationRecord
  belongs_to :laboratory
  
  validates :name      , presence: true
  validates :changed_at, presence: true
  validates :status    , presence: true
  validates :grade     , presence: true
  
  attribute :name      , :string  , default: -> { "" }
  attribute :changed_at, :datetime, default: -> { DateTime.current }
  attribute :status    , :integer , default: -> { statuses.keys.index("at_home") }
  attribute :grade     , :integer , default: -> { grades.keys.index("others") }
  
  enum grade: {
    teacher: 0,
    doctor:  1,
    m_2nd:   2,
    m_1st:   3,
    b_4th:   4,
    b_3rd:   5,
    b_2nd:   6,
    b_1st:   7,
    others:  8
  }
  
  enum status: {
    office:      0,
    experiment:  1,
    machining:   2,
    cafeteria:   3,
    classwork:   4,
    ogigaoka:    5,
    off_campus:  6,
    at_home:     7,
    late:        8,
    job_hunt:    9,
    absence:    10,
    homecaming: 11,
  }
end
