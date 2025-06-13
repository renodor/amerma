class Project < ApplicationRecord
  belongs_to :project_category
  has_many :container_blocks, -> { order(:position) }, as: :containerable, dependent: :destroy
  has_one_attached :cover_photo do |attachable|
    attachable.variant :square,
      preprocessed: true,  # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_fill: [96, 96],
      colorspace: :gray,
      format: "png",
      dither: "FloydSteinberg",
      colors: "6",
      saver: { strip: true }

    attachable.variant :cover,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_fill: [1088, 176],
      colorspace: :gray,
      format: "png",
      dither: "FloydSteinberg",
      colors: "6",
      saver: { strip: true }

    # attachable.variant :cover,
    #   resize_to_fill: [1088, 176],
    #   colorspace: :gray,
    #   format: "png",
    #   ordered_dither: "o8x8"
  end

  scope :visible, -> { where(visible: true) }
  scope :featured, -> { where(featured: true) }

  validates :name, presence: true
  validate :cover_photo_type

  enum :status, {
    completed: 0,
    in_progress: 1,
    planned: 2
  }

  private

  def cover_photo_type
    return if cover_photo.blank? || %w[image/png image/jpeg image/webp image/gif].include?(cover_photo.content_type)

    errors.add :cover_photo, I18n.t("image_format_invalid")
  end
end
