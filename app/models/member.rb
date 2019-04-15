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
  attribute :status       , :integer , default: -> { statuses.keys.index("athome") }
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
    offcampus:  6,
    athome:     7,
    jobhunt:    8,
    absence:     9,
    homecaming: 10,
  }
  
  def active_logs
    logs.where(status: 0..3)
  end
  
  def active_logs_at_day(range)
    logs.where(created_at: range, status: 0..3)
  end
  
  def change_status(next_status, now)
    logs.build(
      total_time: (now.to_i - changed_at.to_i),
      status: status
    )
    update(status: next_status, changed_at: now)
  end
end
