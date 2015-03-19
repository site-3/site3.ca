module ApplicationHelper
  def title(page_title)
    content_for :title, [page_title.to_s, t('site_name')].select(&:present?).join(" | ")
  end

  def body_classes
    [
      controller_name,
      "#{controller_name}-#{action_name}",
    ].join(" ").gsub("_", "-")
  end
end
