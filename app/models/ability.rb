class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new
      if user.Registration?
        can :manage, [Student]
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
      elsif user.Finance?
        can :manage, [Voucher, Receipt, Payment]
        # can :read, [Student]
        can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
        can :read, ActiveAdmin::Page, name: "Cashbook", namespace_name: "admin"
      else
        can :manage, :all #admin role can access all files
      end
    end
  end
