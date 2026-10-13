class Area < ApplicationRecord
  has_many :shops, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end