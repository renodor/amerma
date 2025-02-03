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

  validates :image, presence: true
  validate :image_type

  private

  def image_type
    return if image.blank? || %w[image/png image/jpeg image/webp image/gif].include?(image.content_type)

    errors.add :image, I18n.t("image_format_invalid")
  end
end
