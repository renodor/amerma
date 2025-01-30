module Contentable
  extend ActiveSupport::Concern

  included do
    has_one :content_block, as: :contentable, touch: true, dependent: :nullify
  end
end
