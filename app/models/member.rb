class Member < ApplicationRecord
  has_many   :logs, dependent: :delete_all
  belongs_to :laboratory
  
  ACTIVE_RANGE = 0..4 #食事も含む
  
  validates :lastname     , presence: true
  validates :firstname    , presence: true
  validates :changed_at   , presence: true
  validates :status       , presence: true
  validates :grade        , presence: true
  validates :class_number , presence: true
  validates :go_cafeteria , inclusion: { in: [true, false] }
  
  attribute :lastname     , :string  , default: -> { "" }
  attribute :firstname    , :string  , default: -> { "" }
  attribute :changed_at   , :datetime, default: -> { DateTime.current }
  attribute :status       , :integer , default: -> { statuses.keys.index("athome") }
  attribute :grade        , :integer , default: -> { grades.keys.index("others") }
  attribute :class_number , :integer , default: -> { 0 }
  attribute :go_cafeteria , :boolean , default: -> { true }
  
  enum grade: {
    teacher: 0,
    doctor:  1,
    m_2nd:   2,
    m_1st:   3,
    b_4th_1: 4,
    b_4th_2: 5,
    b_3rd_1: 6,
    b_3rd_2: 7,
    b_2nd_1: 8,
    b_2nd_2: 9,
    b_1st_1: 10,
    b_1st_2: 11,
    others:  12
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
    logs.where(status: ACTIVE_RANGE)
  end
  
  def active_logs_at_day(range)
    logs.where(created_at: range).where(status: ACTIVE_RANGE)
  end
  
  def each_logs_at_day(range, status)
    logs.where(created_at: range).where(status: status)
  end

  def change_status(next_status, now)
    logs.build(
      total_time: (now.to_i - changed_at.to_i),
      status: status
    )
    update(status: next_status, changed_at: now)
  end
  
  def self.active_logs_through_year(month, members)
    member_log = []
    if month < 4
      year = Date.current.financial_year
    else
      year = Date.current.financial_year-1
    end
    
    date = Date.new(year, month)
    members.each do |member|
      tmp_log = member.logs.where(created_at: date.beginning_of_month..date.end_of_month).where(status: ACTIVE_RANGE).group("member_id").sum(:total_time).sort
      if tmp_log.blank?
        tmp_log = [[member.id, 0]]
      end
      tmp_log.each do |k, v|
        member_log << [Member.find(k).lastname, (v/3600.0).round(1)]
      end
    end
    return member_log.to_h
  end
end
