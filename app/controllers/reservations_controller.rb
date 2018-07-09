class ReservationsController < ApplicationController
  before_action :canManage, only: [:confirm_loan, :confirm_return]
  def confirm_loan
    reservation = Reservation.find(params[:id])
    if reservation !=nil
      reservation.isLoan=true
      reservation.expiration_date = DateTime.now.to_date + 1.month
      reservation.save
      redirect_to '/manage_pending_reservations' and return
    end
    redirect_to '/manage_pending_reservations',alert: 'Error when confirming loan...' and return
  end

  def confirm_return
    reservation = Reservation.find(params[:id])
    if reservation !=nil
      reservation.isReturned=true
      reservation.save
      redirect_to '/manage_active_reservations' and return
    end
    redirect_to '/manage_active_reservations',alert: 'Error when confirming return...' and return
  end

  def canManage
    ApplicationHelper.canManageReservations
  end
end
