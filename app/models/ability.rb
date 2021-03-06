# TODO: Refactor this to ablities
class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new # guest user (not logged in)

    if user != nil
      if user.admin?
        can :manage, :all
        can :access, :rails_admin   # grant access to rails_admin
        can :dashboard              # grant access to the dashboard
      elsif user.moderator?
        can :read, :all
        can :create, Comment
        can :update, Comment
      elsif user.author?
        can :read, [Article, Comment, Book]
        can :create, Comment
        # can :update, Book do |book|
        #   book.try(:user_id) == user.id
        # end
      elsif user.user?
        can :read, [Article, Comment, Book]
        can :create, Comment
      elsif user.guest?
        can :read, [Article, Comment, Book]
      end
    else
      can :read, [Article, Comment, Book]
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
