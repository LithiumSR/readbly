class ManagementUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :canManage
  def manage_users
    @users = User.all.paginate(page: params[:page], per_page: 15)
  end

  def change_role
    id = params[:id]
    newrole = params[:changes][:role]
    if !User::ROLES.include?(newrole)
      redirect_to 'manage_users' and return
    end
    user = User.find_by(id: id)
    raise ActiveRecord::RecordNotFound, "Can't find the ActiveRecord for the user" unless !user.nil?
    for role in User::ROLES
      user.remove_role(role.downcase)
    end
    user.add_role(newrole.downcase)
    redirect_to '/manage_users' and return
  end

  def canManage
    if current_user!=nil
      if !current_user.has_role? :admin or !ApplicationHelper.hasValidRole(current_user)
        redirect_to root_path alert: "User not enabled to manage users"
      end
    else
      redirect_to root_path
    end
  end
end
