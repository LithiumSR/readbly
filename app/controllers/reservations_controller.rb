class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :canManage, only: [:confirm_loan, :confirm_return]

  def destroy
    if !user_signed_in?
      redirect_to root_path and return
    end
    reservation = Reservation.find(params[:id])
    if reservation!=nil and ApplicationHelper.isAdmin(current_user)
      reservation.delete
      redirect_back fallback_location: root_path, notice: "Reservation deleted successfully" and return
    elsif reservation!=nil and !reservation.isLoan and (ApplicationHelper.isOperator(current_user) or (ApplicationHelper.isUser(current_user) and reservation.user_id == current_user.id))
      reservation.delete
      redirect_back fallback_location: root_path, notice: "Reservation deleted successfully" and return
    elsif !ApplicationHelper.isAdmin(current_user)
           redirect_to root_path, alert: 'You have no authorization to delete a reservation' and return
    else redirect_back fallback_location: root_path, alert: 'Error when deleting a reservation' and return
    end

  end


  def create
    if !ApplicationHelper.isValidString(params[:book_id])
      redirect_back fallback_location: root_path, alert: 'Missing book id!' and return
    end
    if !ApplicationHelper.hasValidRole(current_user)
      redirect_back fallback_location: root_path, alert: 'Invalid role for user account!' and return
    end
    if params[:user_id].to_i!=current_user.id and !current_user.has_role?(:admin)
      redirect_back fallback_location: root_path, alert: "You don't have the permission to create a reservation for another user!" and return
    end
    Reservation.create!("book_id" => params[:book_id], "user_id" => params[:user_id])
    redirect_back fallback_location: root_path, notice: "Reservation placed successfully"
  end

  def confirm_loan
    reservation = Reservation.find(params[:id])
    if reservation !=nil and !reservation.isLoan and !reservation.isReturned
      reservation.isLoan=true
      reservation.expiration_date = DateTime.now.to_date + 1.month
      reservation.save
      redirect_to '/manage_reservations', notice: "Reservation confirmed successfully" and return
    end
    redirect_to '/manage_reservations',alert: 'Error when confirming loan...' and return
  end

  def confirm_return
    reservation = Reservation.find(params[:id])
    if reservation !=nil and reservation.isLoan and !reservation.isReturned
      reservation.isReturned=true
      reservation.returned_date=DateTime.now
      reservation.save
      redirect_to '/manage_reservations', notice: "Returned registered successfully" and return
    end
    redirect_to '/manage_reservations',alert: 'Error when confirming return...' and return
  end

  def postpone_return
    if !user_signed_in?
      redirect_to root_path and return
    end
    reservation = Reservation.find(params[:id])
    if reservation !=nil and reservation.isLoan
      if ApplicationHelper.isUser(current_user) and (reservation.expiration_date - DateTime.now).to_i>=7
        redirect_to '/manage_reservations',alert: "You can't postpone the expiration date this early..." and return
      end
      if ApplicationHelper.isUser(current_user) and reservation.isPostponed
        redirect_to '/manage_reservations',alert: "You can't postpone this loan again..." and return
      end
      if ApplicationHelper.isUser(current_user) and reservation.user_id != current_user.id
        redirect_to '/manage_reservations',alert: "You can't postpone a loan of another user..." and return
      end
      if ApplicationHelper.isOperator(current_user) and reservation.isPostponed and reservation.postpone_counter>=3
        redirect_to '/manage_reservations',alert: "You can't postpone this reservation more than 3 times..." and return
      end
      reservation.isPostponed=true
      reservation.postpone_counter+=1
      reservation.expiration_date += 1.month
      reservation.save
      redirect_to '/manage_reservations',notice: "Reservation postponed successfully" and return
    end
    redirect_to '/manage_reservations',alert: 'Error when postponing return...' and return
  end

  def canManage
    if current_user!=nil
      if (!current_user.has_role? :admin and !current_user.has_role? :operator) or !ApplicationHelper.hasValidRole(current_user)
        redirect_to root_path alert: "User not enabled to manage reservations"
      end
    else
      redirect_to root_path
    end
  end

  def book_reservations
    @book = Book.find(params[:book_id])
    @reservations = Array(Reservation.find_by('book_id' =>@book.id)).paginate(page: params[:page], per_page: 15)
  end
end
