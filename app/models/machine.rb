class Machine < ApplicationRecord
  belongs_to :shop

  validates :name, presence: true
end