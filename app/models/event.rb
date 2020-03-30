class Event < ApplicationRecord
  belongs_to :laboratory
  
  DEFAULT_START_DAY = Date.current+1.day
  DEFAULT_FINISH_DAY = Date.current+2.day
  
  validates :started_at  , presence: true
  validates :finished_at , presence: true
  validates :status      , presence: true
  validates :title       , presence: true
  validates :all_day     , inclusion: { in: [true, false] }
  validates :member_id   , presence: true
  
  attribute :started_at  , :datetime , default: -> { DEFAULT_START_DAY }
  attribute :finished_at , :datetime , default: -> { DEFAULT_FINISH_DAY }
  attribute :status      , :integer  , default: -> { statuses.keys.index("athome") }
  attribute :title       , :string   , default: -> { "" }
  attribute :all_day     , :boolean  , default: -> { false }
  
  enum status: Member.statuses
end
