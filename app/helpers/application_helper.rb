module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def description(page_description)
    content_for(:description) { page_description }
  end

  def yield_or_default(section, default = '')
    content_for?(section) ? content_for(section) : default
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :hard_wrap => true, :filter_html => true, :no_intraemphasis => true, :fenced_code => true, :gh_blockcode => true)
    markdown.render(text).html_safe
  end
end
