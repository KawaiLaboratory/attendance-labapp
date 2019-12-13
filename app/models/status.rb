class Status < ApplicationRecord
  belongs_to :laboratory
  
  enum color: {
    warning:   0,
    info:      1,
    danger:    2,
    success:   3,
    primary:   4
  }
end
