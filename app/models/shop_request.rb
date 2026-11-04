# frozen_string_literal: true

class ShopRequest < ApplicationRecord
  belongs_to :shop, optional: true
  belongs_to :admin, optional: true

  enum status: { pending: 0, approved: 1, rejected: 2 }, _default: :pending

  validates :shop_name, presence: true
  validates :address, presence: true
  validates :request_type, presence: true
  validates :status, presence: true
  validates :body, presence: true
end
