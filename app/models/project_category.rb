class ProjectCategory < ApplicationRecord
  has_many :projects, -> { order(created_at: :desc) }, dependent: :nullify

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path = "icons/#{icon}.svg"
end
