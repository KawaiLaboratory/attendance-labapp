class Laboratory < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable
  
  validates :name        , presence: true, uniqueness: true, format: { with: /\A[\w@-]*[A-Za-z][\w@-]*\z/ }
  validates :displayname , presence: true
  validates :place       , presence: true
  
  attribute :name        , :string  , default: -> { "laboratory-#{SecureRandom.hex(10)}" }
  attribute :displayname , :string  , default: -> { "研究室" }
  attribute :place       , :integer , default: -> { places.keys.index("others") }
  
  has_many :members, -> { order(:grade, :class_number) }, dependent: :destroy, inverse_of: :laboratory
  has_many :events, dependent: :destroy, inverse_of: :laboratory
  
  accepts_nested_attributes_for :members, allow_destroy: true, reject_if: :reject_member
  
  enum place: {
    ogigaoka:   0,
    building74: 1,
    building61: 2,
    building65: 3,
    others:     4
  }

  def to_param
    name
  end
  
  def reject_member(attributed)
    attributed['lastname'].blank? || attributed['firstname'].blank?
  end
end
