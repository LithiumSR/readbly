module ApplicationHelper
  def boostrap_class(alert)
    { success: 'alert-success', error: 'alert-danger', notice: 'alert-success', warning: 'alert-warning',
      danger: 'alert-danger', alert: 'alert-danger' }[alert.to_sym]
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{boostrap_class(msg_type.to_sym)} fade in") do
        concat(content_tag(:button, id: "close-button", class: "close", type: :button, data: { dismiss: 'alert' }, "aria-label" => :Close) do
          concat content_tag(:span, "&times;".html_safe, "aria-hidden" => true)
        end)
        concat message
      end)
    end
    nil
  end

  def isAdmin(user)
    if user.has_role? :admin
      return true
    end
    return false
  end

  def self.isAdmin(user)
    if user.has_role? :admin
      return true
    end
    return false
  end

  def isOperator(user)
    if user.has_role? :operator
      return true
    end
    return false
  end

  def self.isOperator(user)
    if user.has_role? :operator
      return true
    end
    return false
  end

  def isUser(user)
    if user.has_role? :user
      return true
    end
    return false
  end

  def self.isUser(user)
    if user.has_role? :user
      return true
    end
    return false
  end

  def self.hasValidRole(user)
    if(!isUser(user) and !isOperator(user) and !isAdmin(user))
      return false
    end
    return true
  end

  def getRole(user)
    if isAdmin(user)
      return 'Admin'
    elsif isOperator(user)
      return 'Operator'
    elsif isUser(user)
      return 'User'
    end
    return 'Unrecognized'
  end

  def getEmailById(id)
    user = User.find_by_id(id)
    return user.email
  end

  def self.isValidString(string)
    if string.nil? or string.strip.empty?
      return false
    end
    return true
  end
end
