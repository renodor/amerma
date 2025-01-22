module ApplicationHelper
  def project_status(status)
    colors = case status
             when "completed"
                "text-white bg-black"
             when "in_progress"
                "text-white bg-gray-500"
             when "planned"
                "border border-black"
             end

    content_tag(:span, t(status), class: "px-3 py-1 rounded-full #{colors}")
  end
end
