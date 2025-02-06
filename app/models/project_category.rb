class ProjectCategory < ApplicationRecord
  has_many :projects, -> { where(visible: true) }, dependent: :nullify

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }

  def icon_path
    "icons/#{icon}.svg"
  end
end
