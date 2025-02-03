class TeamMember < ApplicationRecord
  has_one_attached :photo do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_limit: [120, 120],
      colorspace: :gray,
      format: "png",
      dither: "FloydSteinberg",
      colors: "6",
      saver: { strip: true }
  end

  validates :name, presence: true
  validate :photo_type

  private

  def photo_type
    return if photo.blank? || %w[image/png image/jpeg image/webp image/gif].include?(photo.content_type)

    errors.add :photo, I18n.t("image_format_invalid")
  end
end
