class ReservationsController < ApplicationController
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
end
