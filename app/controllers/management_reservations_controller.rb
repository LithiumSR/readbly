class ManagementReservationsController < ApplicationController
  before_action :isEnabled
  def manage_active_reservations

  end

  def manage_pending_reservations
    @pending_reservations = Reservation.all.select{|i| i.isReturned == false}.select{|i| i.isLoan == false}.paginate(page: params[:page], per_page: 15)
  end

  def show_completed_reservations

  end

  def isEnabled
    if user_signed_in?
      user = current_user
      if !user.has_role? :admin and !user.has_role? :operator
        redirect_to root_path alert: "User not enabled to manage reservations"
      end
    else
      redirect_to root_path
    end
  end

end
