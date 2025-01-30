class ContentBlock < ApplicationRecord
  belongs_to :container_block
  delegated_type :contentable, types: %w[TextBlock ImageBlock], dependent: :destroy, optional: true

  scope :ordered, -> { order(:position) }
end
