module AdminHelper
  def sidebar_link(text, path)
    link_to(
      text,
      path,
      class: "px-3 py-2 rounded text-gray-300 transition-colors hover:text-white hover:bg-slate-800 data-[active='true']:text-white data-[active='true']:bg-slate-800",
      data: { active: current_page?(path) }
    )
  end
end
