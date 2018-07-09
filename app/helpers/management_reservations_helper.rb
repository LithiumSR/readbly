module ManagementReservationsHelper
  def getBookById(id)
    return Book.find_by_id(id)
  end
end
