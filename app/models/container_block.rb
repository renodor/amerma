class ContainerBlock < ApplicationRecord
  belongs_to :containerable, polymorphic: true
  has_many :content_blocks, dependent: :destroy

  scope :ordered, -> { order(:position) }

  def column_count_classes
    case column_count
    when 1
      "grid-cols-1"
    when 2
      "grid-cols-1 sm:grid-cols-2"
    when 3
      "grid-cols-1 sm:grid-cols-2 md:grid-cols-3"
    when 4
      "grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4"
    end
  end
end
