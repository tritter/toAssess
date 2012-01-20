class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Category
      can :manage, Course
      can :manage, User
      can :read, Exam
      can :read, Question
      can :destroy, Exam
      can :destroy, Question
    else
      can :read, Exam
      can :read, Question
      can :create, Exam
      can :create, Question
      can :update, Exam do |exam|
        exam.try(:user) == user
      end
      can :update, Question do |question|
        question.try(:user) == user
      end
      can :update, User do |profile|
        profile == user
      end
      can :destroy, Exam do |exam|
        exam.try(:user) == user
      end
      can :destroy, Question do |question|
        question.try(:user) == user
      end
    end
  end
end