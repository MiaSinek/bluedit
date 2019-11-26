module ApplicationHelper
  def render_svg(name, styles: "fill-current text-gray-400", title: nil)
    filename = "#{name}.svg"
    title ||= name.underscore.humanize
    inline_svg(filename, aria: true, nocomment: true, title: title, class: styles)
  end

  def alert_class_for(type)
    if type == "alert"
      "bg-red-500"
    elsif type == "notice"
      "bg-green-500"
    end
  end

  #Multi-line comment
  def comment
  end
end


# <% if type == "alert" %>
#   <div class="bg-red-500">
#     <div class="container px-2 mx-auto py-4 text-white text-center font-medium font-sans"><%= message %></div>
#   </div>
# <% end %>
# <% if type == "notice" %>
#   <div class="bg-green-500">
#     <div class="container px-2 mx-auto py-4 text-white text-center font-medium font-sans"><%= message %></div>
#   </div>
# <% end %>
