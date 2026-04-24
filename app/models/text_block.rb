class TextBlock < ApplicationRecord
  include Contentable

  has_rich_text :text
  has_rich_text :text_en

  before_save :add_target_blank_to_links, unless: :is_raw_html?

  private

  def add_target_blank_to_links
    [rich_text_text, rich_text_text_en].compact.each do |rich_text|
      next if rich_text.body.blank?

      doc = Nokogiri::HTML::DocumentFragment.parse(rich_text.body.to_html)
      links = doc.css("a[href]")
      next if links.empty?

      links.each do |a|
        a["target"] = "_blank"
        a["rel"] = "noopener noreferrer"
      end
      rich_text.body = doc.to_html
    end
  end
end
