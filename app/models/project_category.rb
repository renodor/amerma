class ProjectCategory < ApplicationRecord
  has_many :projects, -> { order(:position) }, dependent: :nullify

  has_rich_text :description
  has_rich_text :description_en

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path = "icons/pixel-pack/#{icon}.svg"
end
