class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    #if user.client?
    #  can :manage, Product, user_id: user.id
    if user.admin?
      can :manage
    else
      can :read, :all
    end
  end
end