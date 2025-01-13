class TextBlock < ApplicationRecord
  include Contentable

  has_rich_text :text
end
