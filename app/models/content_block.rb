class ContentBlock < ApplicationRecord
  belongs_to :container_block
  delegated_type :contentable, types: %w[TextBlock ImageBlock], dependent: :destroy

  scope :ordered, -> { order(:position) }
end
