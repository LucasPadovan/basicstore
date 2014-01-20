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

  def link_to_show(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.show')
    options['data-show-tooltip'] ||= true

    link_to '&#xe074;'.html_safe, *args, options
  end

  def link_to_edit(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.edit')
    options['data-show-tooltip'] ||= true

    link_to '&#x270e;'.html_safe, *args, options
  end

  def link_to_destroy(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.delete')
    options['method'] ||= :delete
    options['data-confirm'] ||= t('messages.confirmation')
    options['data-show-tooltip'] ||= true

    link_to content_tag(:i, '', class: 'icon-remove'), *args, options
  end

  def srbuj_link_to_new(name, *args)
    options = args.extract_options!

    options['class'] ||= 'btn btn-primary stitched'
    options['title'] ||= t('label.new')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true
    link_to content_tag(:i, '', class: 'icon-plus-sign') + ' ' + name, *args, options
  end

  def srbuj_link_to_edit(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.edit')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true

    link_to content_tag(:i, '', class: 'icon-pencil'), *args, options
  end

  def srbuj_link_to_show(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.show')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true

    link_to content_tag(:i, '', class: 'icon-zoom-in'), *args, options
  end

  def srbuj_link_to_destroy(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.delete')
    options['method'] ||= :delete
    options['data-confirm'] ||= t('messages.confirmation')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= nil

    link_to content_tag(:i, '', class: 'icon-remove'), *args, options
  end
end
