class TextBlock < ApplicationRecord
  include Contentable

  has_rich_text :text
  has_rich_text :text_en
end
