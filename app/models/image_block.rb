class ImageBlock < ApplicationRecord
  include Contentable

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 130]
  end
end
