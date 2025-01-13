class Project < ApplicationRecord
  belongs_to :project_category
  has_many :container_blocks, as: :containerable, dependent: :destroy

  validates :name, presence: true
end
