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
  end
end
