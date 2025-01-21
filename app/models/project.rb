class Project < ApplicationRecord
  belongs_to :project_category
  has_many :container_blocks, as: :containerable, dependent: :destroy
  has_one_attached :cover_photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 130]
  end

  scope :visible, -> { where(visible: true) }

  validates :name, presence: true

  enum :status, {
    completed: 0,
    in_progress: 1,
    planned: 2
  }
end
