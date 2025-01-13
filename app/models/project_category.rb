class ProjectCategory < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name, presence: true

  enum status: {
    closed: 0,
    running: 1,
    planned: 2
  }
end
