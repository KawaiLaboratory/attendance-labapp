class Laboratory < ApplicationRecord
  has_secure_password validations: true
  
  validations :loginname, presence: true, uniqueness: true
end
