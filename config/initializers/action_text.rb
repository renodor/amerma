Rails.application.config.after_initialize do
  Rails::HTML5::SafeListSanitizer.allowed_attributes.merge(%w[target rel])
end
