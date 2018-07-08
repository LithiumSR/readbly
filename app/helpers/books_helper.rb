module BooksHelper
  def canManageBooks(user)
    if user.has_role? :admin or user.has_role? :operator
      return true
    end
    return false
  end
end
