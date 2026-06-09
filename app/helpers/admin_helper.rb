module AdminHelper
  def sidebar_link(text, path, controller_name: nil)
    controller_name ||= path[1..]
    link_to(
      text,
      path,
      class: "px-3 py-2 text-gray-300 transition-colors hover:text-white hover:bg-gray-700" \
             "data-[active='true']:text-white data-[active='true']:bg-gray-700",
      data: { active: controller_name == params[:controller] }
      )
  end

  def safe_image_variant_url(image, variant_name:)
    return "" if image.blank?

    image.variant(variant_name)
  rescue ActiveStorage::InvariableError
    ""
  end
end
