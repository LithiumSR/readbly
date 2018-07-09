class ManagementReservationsController < ApplicationController
  before_action :canManage
  def manage_active_reservations

  end

  def manage_pending_reservations
    @pending_reservations = Reservation.all.select{|i| i.isReturned == false}.select{|i| i.isLoan == false}.paginate(page: params[:page], per_page: 15)
  end

  def show_completed_reservations

  end

  def canManage
    ApplicationHelper.canManageReservations
  end

end
