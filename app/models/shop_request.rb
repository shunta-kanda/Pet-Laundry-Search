# frozen_string_literal: true

class ShopRequest < ApplicationRecord
  belongs_to :shop, optional: true
  belongs_to :admin, optional: true

  validates :shop_name, presence: true
  validates :address, presence: true
  validates :request_type, presence: true
  validates :status, presence: true
  validates :body, presence: true
end
