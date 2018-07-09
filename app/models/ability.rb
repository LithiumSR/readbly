class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    #if user.client?
    #  can :manage, Product, user_id: user.id
    if user.has_role? :admin
      can :manage, :all
      can :read, :all
      end
    if user.has_role? :operator
      can :read, Book
      can :manage, Book
      can :manage, Reservation
      can :read, Reservation
      end
    if user.has_role? :user
      can :read, Book
      can :manage, Reservation, user_id: user.id
      can :read, Reservation
    end
  end
end