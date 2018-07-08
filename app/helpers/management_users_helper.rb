module ManagementUsersHelper
  def isAdmin(user)
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

  def getRole(user)
    if user.has_role? :admin
      return 'Admin'
    elsif user.has_role? :operator
      return 'Operator'
    end
  else return 'User'
  end
end
