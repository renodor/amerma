class ContainerBlock < ApplicationRecord
  belongs_to :containerable, polymorphic: true
  has_many :content_blocks, dependent: :destroy
end
