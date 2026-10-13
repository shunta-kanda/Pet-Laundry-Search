# frozen_string_literal: true

class Shop < ApplicationRecord
  belongs_to :area
  has_many :machines, dependent: :destroy
  has_many :shop_requests, dependent: :destroy

  validates :name, presence: true
end
