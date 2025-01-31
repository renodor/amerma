module ApplicationHelper
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
end
