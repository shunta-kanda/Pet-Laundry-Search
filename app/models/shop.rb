# frozen_string_literal: true

class Shop < ApplicationRecord
  belongs_to :area
  has_many :machines, dependent: :destroy
  # has_many :shop_requests, dependent: :destroy

  accepts_nested_attributes_for :machines, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :address, presence: true
  validates :area_id, presence: true
end
