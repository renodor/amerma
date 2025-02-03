class Page < ApplicationRecord
  has_many :container_blocks, as: :containerable, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
