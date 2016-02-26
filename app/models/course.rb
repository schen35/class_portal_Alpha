class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :user

  # search course with course title
  def self.search(search)
    if search
      self.where('"courses"."Title" LIKE ?', "%#{search}%")
    else
      self.all
    end

  end


  # validates_presence_of :course_id
  # validates_uniqueness_of :course_id
  # validates_presence_of :start_date
  # validates_presence_of :end_date

end
