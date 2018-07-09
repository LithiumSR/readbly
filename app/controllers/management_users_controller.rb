class ManagementUsersController < ApplicationController
  before_action :canManage
  def manage_users
    @users = User.all.paginate(page: params[:page], per_page: 15)
  end

  def change_role
    email = params[:id]
    newrole = params[:changes][:role]
    if !User::ROLES.include?(newrole)
      redirect_to 'manage_users' and return
    end
    user = User.find_by(email: email)
    for role in User::ROLES
      user.remove_role(role.downcase)
    end
    user.add_role(newrole.downcase)
    redirect_to '/manage_users' and return
  end

  def promote
    email = params[:id]
    role = params[:role]
    if !User::ROLES.include?(role)
      redirect_to 'manage_users' and return
    end
    user = User.find_by(email: email)
    if role=='Operator'
      user.add_role(:operator)
    elsif role=='Admin'
      user.add_role(:admin)
    end
    redirect_to '/manage_users' and return
  end

  def demote
    email = params[:id]
    role = params[:role]
    if !User::ROLES.include?(role)
      redirect_to 'manage_users' and return
    end
    user = User.find_by(email: email)
    if role=='Operator'
      user.remove_role(:operator)
    elsif role=='Admin'
      user.remove_role(:admin)
    end
    redirect_to '/manage_users' and return
  end

  def canManage
    if current_user!=nil
      if !current_user.has_role? :admin
        redirect_to root_path alert: "User not enabled to manage users"
      end
    else
      redirect_to root_path
    end
  end
end
