require 'redcarpet'

module ApplicationHelper

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      autolink:        true,
      tables:          true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true,
      with_toc_data: true
    }
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, options) 
    markdown.render(text).html_safe
  end

  def TOC(text, level: 2)
    options = {
      nesting_level: level,
    }
    renderer = Redcarpet::Render::HTML_TOC
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''

    content_tag(:li, class: class_name) do
      link_to link_text, link_path
    end
  end

end
