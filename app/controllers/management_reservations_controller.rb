class ManagementReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :hasValidRole
  before_action :canManage, only: [:manage_reservations]
  def manage_reservations
    @active_reservations = Reservation.all.select{|i| !i.isReturned and i.isLoan}.paginate(page: params[:page], per_page: 15)
    @pending_reservations = Reservation.all.select{|i| !i.isReturned and !i.isLoan}.paginate(page: params[:page], per_page: 15)
    @completed_reservations = Reservation.all.select{|i| i.isReturned and i.isLoan}.paginate(page: params[:page], per_page: 15)
  end


  def my_reservations
    @active_reservations = Reservation.all.select{|i| !i.isReturned and i.isLoan and i.user_id == current_user.id}.paginate(page: params[:page], per_page: 15)
    @pending_reservations = Reservation.all.select{|i| !i.isReturned and !i.isLoan and i.user_id == current_user.id}.paginate(page: params[:page], per_page: 15)
    @completed_reservations = Reservation.all.select{|i| i.isReturned and i.isLoan and i.user_id == current_user.id}.paginate(page: params[:page], per_page: 15)
  end

  def canManage
    if current_user!=nil
      if !current_user.has_role? :admin and !current_user.has_role? :operator
        redirect_to root_path alert: "User not enabled to manage reservations"
      end
    else
      redirect_to root_path
    end
  end

  def hasValidRole
    if current_user!=nil && !ApplicationHelper.hasValidRole(current_user)
      redirect_to root_path alert: "Invalid role detected"
    end
  end
end
