class Member < ApplicationRecord
  belongs_to :laboratory
  
  attribute :changed_at, :datetime, default: -> {DateTime.current}
  
  validates :name, presence: true
  enum grade: {
    others:  0,
    b_1st:   1,
    b_2nd:   2,
    b_3rd:   3,
    b_4th:   4,
    m_1st:   5,
    m_2nd:   6,
    doctor:  7,
    teacher: 8
  }
  
  
end
