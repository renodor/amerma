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

  scope :ordered, -> { order(:position) }

  validates :name, :position, presence: true
  validate :photo_type

  before_create :set_position

  private

  def photo_type
    return if photo.blank? || %w[image/png image/jpeg image/webp image/gif].include?(photo.content_type)

    errors.add :photo, I18n.t("image_format_invalid")
  end

  def set_position
    self.position = (TeamMember.maximum(:position) || 0) + 1
  end
end
