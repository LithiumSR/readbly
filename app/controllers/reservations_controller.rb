class ReservationsController < ApplicationController
  before_action :canManage, only: [:confirm_loan, :confirm_return]
  def confirm_loan
    reservation = Reservation.find(params[:id])
    if reservation !=nil
      reservation.isLoan=true
      reservation.expiration_date = DateTime.now.to_date + 1.month
      reservation.save
      redirect_to '/manage_reservations' and return
    end
    redirect_to '/manage_reservations',alert: 'Error when confirming loan...' and return
  end

  def confirm_return
    reservation = Reservation.find(params[:id])
    if reservation !=nil and reservation.isLoan
      reservation.isReturned=true
      reservation.returned_at=DateTime.now
      reservation.save
      redirect_to '/manage_reservations' and return
    end
    redirect_to '/manage_reservations',alert: 'Error when confirming return...' and return
  end

  def postpone_return
    reservation = Reservation.find(params[:id])
    if reservation !=nil and reservation.isLoan
      if ApplicationHelper.isUser(current_user) and (reservation.expiration_date - DateTime.now).to_i>=7
        redirect_to '/manage_reservations',alert: "You can't postpone the expiration date this early!..." and return
      end
      if ApplicationHelper.isUser(current_user) and reservation.isPostponed
        redirect_to '/manage_reservations',alert: "You can't postpone this reservation again!..." and return
      end
      reservation.isPostponed=true
      reservation.expiration_date += 1.month
      reservation.save
      redirect_to '/manage_reservations' and return
    end
    redirect_to '/manage_reservations',alert: 'Error when postponing return...' and return
  end

  def canManage
    ApplicationHelper.canManageReservations(current_user)
  end
end
