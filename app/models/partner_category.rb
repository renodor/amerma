class PartnerCategory < ApplicationRecord
  has_many :partners, -> { order(:position) }, dependent: :nullify

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path = "icons/pixel-pack/#{icon}.svg"
end
