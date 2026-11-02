# frozen_string_literal: true

class Machine < ApplicationRecord
  belongs_to :shop

  validates :name, presence: true
  validates :quantity, presence: true
end
