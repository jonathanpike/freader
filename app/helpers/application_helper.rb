module ApplicationHelper
  def show_errors(object, field_name)
    if object.errors.any?
      unless object.errors.full_messages_for(field_name).blank?
        content_tag(:p, object.errors.full_messages_for(field_name).join(", "), class: "error-messages")
      end
    end
  end
end
