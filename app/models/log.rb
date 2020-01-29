class Log < ApplicationRecord
  belongs_to :member
  
  validates :total_time, presence: true
  validates :status,     presence: true
  
  attribute :total_time, :integer, default: -> { 0 }
  
  enum status: Member.statuses
  ACTIVE_RANGE = Member::ACTIVE_RANGE
  
  def self.active_logs_through_year(month)
    member_log = []
    date = Date.new(Date.current.financial_year, month)
    tmp_log = where(created_at: date.beginning_of_month..date.end_of_month).where(status: ACTIVE_RANGE).group("member_id").sum(:total_time)
    tmp_log.each do |k, v|
      member_log << [Member.find(k).lastname, (v/3600.0).round(1)]
    end
    return member_log.to_h
  end
end
