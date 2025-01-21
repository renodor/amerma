class ContainerBlock < ApplicationRecord
  belongs_to :containerable, polymorphic: true
  has_many :content_blocks, dependent: :destroy

  scope :ordered, -> { order(:position) }
end
