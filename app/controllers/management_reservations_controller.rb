class ManagementReservationsController < ApplicationController
  before_action :canManage
  def manage_reservations
    @active_reservations = Reservation.all.select{|i| !i.isReturned}.select{|i| i.isLoan}.paginate(page: params[:page], per_page: 15)
    @pending_reservations = Reservation.all.select{|i| !i.isReturned}.select{|i| !i.isLoan}.paginate(page: params[:page], per_page: 15)
    @completed_reservations = Reservation.all.select{|i| i.isReturned}.select{|i| i.isLoan}.paginate(page: params[:page], per_page: 15)
  end


  def my_reservations
    @active_reservations = Reservation.all.select{|i| !i.isReturned}.select{|i| i.isLoan}.select{|i| i.user_id = current_user.id}.paginate(page: params[:page], per_page: 15)
    @pending_reservations = Reservation.all.select{|i| !i.isReturned}.select{|i| !i.isLoan}.select{|i| i.user_id = current_user.id}.paginate(page: params[:page], per_page: 15)
    @completed_reservations = Reservation.all.select{|i| i.isReturned}.select{|i| i.isLoan}.select{|i| i.user_id = current_user.id}.paginate(page: params[:page], per_page: 15)
  end

  def canManage
    ApplicationHelper.canManageReservations(current_user)
  end

end
