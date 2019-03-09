class Laboratory < ApplicationRecord
  has_secure_password
  
  validates :loginname,   presence: true, uniqueness: true, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }
  validates :displayname, presence: true
  validates :place,       presence: true
  
  attribute :loginname,   :string  , default: -> { "laboratory#{DateTime.current.to_i}" }
  attribute :displayname, :string  , default: -> { "研究室" }
  attribute :place,       :integer , default: -> { places.keys.index("others") }
  
  has_many :members, dependent: :destroy, inverse_of: :laboratory
  accepts_nested_attributes_for :members, allow_destroy: true, reject_if: :reject_member
  
  enum place: {
    ogigaoka:   0,
    building74: 1,
    building61: 2,
    building65: 3,
    others:     4
  }
  
  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
  
  def to_param
    loginname
  end
  
  def reject_member(attributed)
    attributed['lastname'].blank? || attributed['firstname'].blank?
  end
end
