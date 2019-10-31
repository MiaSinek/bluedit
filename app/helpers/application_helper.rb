module ApplicationHelper
  def render_svg(name, stlyes: "fill-current text-grey-400", title: nil)
    filename = "#{name}.svg"
    title  ||= name.underscore.humanize
    inline_svg(filename, aria: true, nocomment: true, title: title, class: styles)
  end
end
