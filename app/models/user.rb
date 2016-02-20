class User < ActiveRecord::Base
  enum role: [:student, :instructor, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?
  # setup model to filter out current user
  # edit function would be else where implemented
  scope :all_except, ->(user) { where.not(id: user) }


  def set_default_role
    self.role ||= :student
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :enrollments, association_foreign_key: :user_id
  has_many :courses, through: :enrollments

  validates_presence_of :email, :password
  validates_uniqueness_of :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end

