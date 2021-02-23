class RestaurantPolicy < ApplicationPolicy
  # policy for the restaurants controller
  # need to authorize action by action
  class Scope < Scope
    def resolve
      # scope.all #scope stands for the name of your class which is Restaurant
      # Restaurant.all #class method .all from Active Record
      # scope.where(user: user)
      scope.all
      # Restaurant.where(user: current_user)
    end
  end


  def create?
    true
  end


  def show?
    true
  end

  def update?
    # it needs to match the current_user and the current_user needs to be the owner of the resto
    # if user is the current_user and the owner of the resto then he can edit/update the resto.
    # restaurant is called record
    # current_user is called user
    # if @restaurant.user == current_user
    # current_user.admin
    # user is current_user (user is what you use in pundit)
    # record is @restaurant (record is what you use in pundit)
    # record.user == user || user.admin
    owner_or_admin?
  end

  def destroy?
    # @restaurant.user == current_user
    # record.user == user || user.admin
    owner_or_admin?
  end

  def index?
    true
  end

  private

  def owner_or_admin?
    record.user == user || user.admin
  end
end
