class Page < ApplicationRecord
  has_many :container_blocks, as: :containerable, dependent: :destroy
  has_one_attached :banner do |attachable|
    attachable.variant :default,
      preprocessed: true, # TODO: as variant are preprocessed we could remove the original image to save space
      colorspace: :gray,
      format: "png",
      dither: "FloydSteinberg",
      colors: "6",
      saver: { strip: true }
  end

  accepts_nested_attributes_for :container_blocks

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
