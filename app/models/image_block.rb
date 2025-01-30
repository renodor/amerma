class ImageBlock < ApplicationRecord
  include Contentable

  has_one_attached :image do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      colorspace: :gray,
      format: "png",
      dither: "FloydSteinberg",
      colors: "6",
      saver: { strip: true }
  end
end
