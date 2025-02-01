class Partner < ApplicationRecord
  has_one_attached :logo do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_limit: [120, 120]
  end

  validates :name, presence: true
  validate :logo_type

  private

  def logo_type
    unless %w[image/png image/jpeg image/webp image/gif].include?(logo.content_type)
      errors.add :logo, I18n.t("image_format_invalid")
    end
  end
end
