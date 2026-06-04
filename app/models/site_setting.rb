class SiteSetting < ApplicationRecord
  has_one_attached :logo do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_limit: [256, 256]
  end
end
