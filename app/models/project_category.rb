class ProjectCategory < ApplicationRecord
  has_many :projects, dependent: :nullify

  validates :name, presence: true
end
