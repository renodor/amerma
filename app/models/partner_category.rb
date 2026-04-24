class PartnerCategory < ApplicationRecord
  has_many :partners, dependent: :nullify

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path = "icons/#{icon}.svg"
end
