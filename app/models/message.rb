class Message < ApplicationRecord
  validates :name, :email, :body, presence: true
end
