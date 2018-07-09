class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  after_create :assign_default_values

  def assign_default_values
    self.isReturned = false
    self.isLoan = false
    self.isPostponed = false
    self.request_date = DateTime.now
    self.postpone_counter = 0
  end

end
