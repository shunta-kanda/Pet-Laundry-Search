# frozen_string_literal: true

class Shop < ApplicationRecord
  belongs_to :area
  has_many :machines, dependent: :destroy

  accepts_nested_attributes_for :machines, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :address, presence: true
  validates :area_id, presence: true

  def build_machine_if_empty
    machines.build if machines.empty?
  end
end
