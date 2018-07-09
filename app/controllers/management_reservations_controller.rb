class ManagementReservationsController < ApplicationController
  before_action :canManage
  def manage_reservations
    @active_reservations = Reservation.all.select{|i| i.isReturned == false}.select{|i| i.isLoan == true}.paginate(page: params[:page], per_page: 15)
    @pending_reservations = Reservation.all.select{|i| i.isReturned == false}.select{|i| i.isLoan == false}.paginate(page: params[:page], per_page: 15)
    @completed_reservations = Reservation.all.select{|i| i.isReturned == true}.select{|i| i.isLoan == true}.paginate(page: params[:page], per_page: 15)
  end

  def canManage
    ApplicationHelper.canManageReservations(current_user)
  end

end
