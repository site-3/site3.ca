module ApplicationHelper
  def body_classes
    [
      controller_name,
      "#{controller_name}-#{action_name}",
    ].join(" ").gsub("_", "-")
  end
end
