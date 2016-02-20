class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # define roles
    can :do_as_superadmin, :all if user.role == 'superadmin'
    can :do_as_admin, :all if user.role == 'superadmin'
    can :do_as_admin, :all if user.role =='admin'
    can :do_as_instructor, :all if user.role == 'instructor'
    can :do_as_student, :all if user.role =='student'

    # admin can not destroy self
   case user.role
     when 'admin'
       cannot :destroy, User do |x|
         x.id == user.id
       end
    end

  end

end
