class ProjectCategory < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name, :position, presence: true

  scope :ordered, -> { order(:position) }
end
