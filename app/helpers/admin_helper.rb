module AdminHelper
  def sidebar_link(text, path)
    link_to(
      text,
      path,
      class: "px-3 py-2 text-gray-300 transition-colors hover:text-white hover:bg-gray-700 data-[active='true']:text-white data-[active='true']:bg-gray-700",
      data: { active: path[1..] == params[:controller] }
      )
  end
end
