class Partner < ApplicationRecord
  belongs_to :partner_category

  has_one_attached :logo do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      resize_to_limit: [120, 120]
  end

  scope :ordered, -> { order(:partner_category_id, :position) }

  validates :name, presence: true
  validate :logo_type

  before_create :set_position

  private

  def logo_type
    return if logo.blank? || %w[image/png image/jpeg image/webp image/gif].include?(logo.content_type)

    errors.add :logo, I18n.t("image_format_invalid")
  end

  def set_position
    self.position = (Partner.where(partner_category_id: partner_category_id).maximum(:position) || 0) + 1
  end
end
