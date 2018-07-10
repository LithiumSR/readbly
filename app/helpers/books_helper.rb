module BooksHelper
  def canManageBooks(user)
    if user.has_role? :admin or user.has_role? :operator
      return true
    end
    return false
  end

  def isAvaiable(book)
    reservations = Reservation.all.select {|i| i.book_id == book.id and i.isReturned == false}
    if reservations.nil? or reservations.length==0
      true
    else
      false
    end
  end
end
