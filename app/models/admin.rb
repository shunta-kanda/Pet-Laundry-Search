# frozen_string_literal: true

class Admin < ApplicationRecord
  has_secure_password # パスワードのハッシュ化（password_digestを使う場合に必要）

  has_many :shop_requests, dependent: :nullify

  validates :email, presence: true, uniqueness: true
end
