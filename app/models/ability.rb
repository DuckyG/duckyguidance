class Ability
  include CanCan::Ability

  def initialize(user)
    #alias_action :modify
    user ||= User.new

    if user.school

      if user.counselor?
        can :update,  Student, school_id: user.school_id
        can :update, [Group,SmartGroup], school_id: user.school_id, user_id: nil
        can [:destroy,:update], [Group,SmartGroup], school_id: user.school_id, user_id: user.id

        can :read, [Student,Category,Group,SmartGroup,Tag], school_id: user.school_id

        can [:read, :unassigned], Note, school_id: user.school_id, confidentiality_level: "department"
        can [:read, :unassigned], Note, school_id: user.school_id, confidentiality_level: "just_me", counselor_id: user.id

        can [:update,:destroy], Note, counselor_id: user.id

        can :create, [Note,Student,Group,SmartGroup]

        can [:new_field, :snapshot, :search, :report], :all, school_id: user.school_id
      end

      if user.director?
        can :create, Category
        can [:read, :unassigned], Note, school_id: user.school_id, confidentiality_level: "director"
        can :update, Category, school_id: user.school_id
        can :destroy, [Category,Student,Group,SmartGroup], school_id: user.school_id
      end
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
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
