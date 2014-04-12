module ApplicationHelper
  def flash_type(key)
    case key
    when :alert then :warning
    when :notice then :success
    when :error then :danger
    end
  end

  def flash_content(key, value)
    unless value.blank? || key == :timedout
      content_tag(:div, value, class: "alert alert-#{flash_type(key)}").html_safe
    end
  end

  def get_date_for(tasks_by_day)
    date = tasks_by_day.first.updated_at.localtime
    date.today? ? "Today" : date.strftime("%a, %b %-d")
  end
end
