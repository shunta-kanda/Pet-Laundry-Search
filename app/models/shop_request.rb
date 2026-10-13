# frozen_string_literal: true

class ShopRequest < ApplicationRecord
  belongs_to :shop
  belongs_to :admin, optional: true

  validates :shop_name, presence: true
  validates :body, presence: true
end
