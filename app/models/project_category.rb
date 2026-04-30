class ProjectCategory < ApplicationRecord
  has_many :projects, -> { order(created_at: :desc) }, dependent: :nullify

  has_rich_text :long_description

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path = "icons/#{icon}.svg"
end
