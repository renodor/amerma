class ContentBlock < ApplicationRecord
  belongs_to :container_block
  delegated_type :contentable, types: %w[TextBlock ImageBlock], dependent: :destroy, optional: true

  accepts_nested_attributes_for :contentable

  validates_associated :contentable
end
