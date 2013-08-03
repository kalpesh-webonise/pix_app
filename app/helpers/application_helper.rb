module ApplicationHelper
  def html_errors(object)
    errors = ''
    if object.errors.any?
      errors += '<div class="alert fade in alert-error"><button class="close" data-dismiss="alert">x</button><strong>Please fix following errors</strong><br>'
      errors +=  object.errors.full_messages.join("<br>")
      errors += "</div>"
    end
    raw errors
  end

  def display_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
