module ApplicationHelper
  def render_translated_action_text(record, attribute)
    action_text = translates(record, attribute)
    record.try(:is_raw_html?) ? action_text.body&.html_safe : action_text
  end

  def translates(record, attribute)
    # Safe to ignore Brakeman warning as params[:locale] is scoped at route level
    record.try("#{attribute}_#{params[:locale]}").presence || record.try(attribute)
  end

  def project_status(status)
    colors = case status
    when "completed"
      "text-white bg-gray-500"
    when "in_progress"
      "bg-gray-300"
    when "planned"
      "text-gray-700 border border-gray-700"
    end

    content_tag(:span, t(status), class: "px-3 py-1 rounded-full #{colors}")
  end

  def display_thumbnail(project)
    photo =
      if project.thumbnail.attached?
        project.thumbnail.variant(:square)
      elsif project.cover_photo.attached?
        project.cover_photo.variant(:square)
      end

    image_tag(photo, class: "w-24 h-24 object-cover grayscale") if photo
  end
end
