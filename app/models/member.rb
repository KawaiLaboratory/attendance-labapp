class Member < ApplicationRecord
  has_many   :logs
  belongs_to :laboratory
  
  validates :lastname     , presence: true
  validates :firstname    , presence: true
  validates :changed_at   , presence: true
  validates :status       , presence: true
  validates :grade        , presence: true
  validates :go_cafeteria , inclusion: { in: [true, false] }
  
  attribute :lastname     , :string  , default: -> { "" }
  attribute :firstname    , :string  , default: -> { "" }
  attribute :changed_at   , :datetime, default: -> { DateTime.current }
  attribute :status       , :integer , default: -> { statuses.keys.index("at_home") }
  attribute :grade        , :integer , default: -> { grades.keys.index("others") }
  attribute :go_cafeteria , :boolean , default: -> { true }
  
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
    ogigaoka:    3,
    cafeteria:   4,
    classwork:   5,
    off_campus:  6,
    at_home:     7,
    job_hunt:    8,
    absence:     9,
    homecaming: 10,
  }
  
  def active_times
    active_logs = logs.where(status: 0..3)
    active_logs.sum(:total_time)
  end
end
