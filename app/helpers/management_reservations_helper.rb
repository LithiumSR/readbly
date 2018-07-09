module ManagementReservationsHelper
  def getBookById(id)
    return Book.find_by_id(id)
  end

  def nearExpirationDate(date)
    if (date - DateTime.now).to_i <=7
      return true
    end
    return false
  end
end
