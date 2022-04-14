# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, Job
      can :read, Application
    else
      can :read, :all
      can :create, Application
    end
  end
end
