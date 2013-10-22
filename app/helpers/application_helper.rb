module ApplicationHelper
  def hidden_div_if(condition, attributes={}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def current_section(paths)
    if paths.any? { |path| current_page?(path) }
      'current-section'
    end
  end

  def current_subsection(paths)
    if paths.any? { |path| current_page?(path) }
      'current-subsection'
    end
  end
end
