class User < ActiveRecord::Base
  enum role: [:student, :instructor, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?
  # setup model to filter out current user
  # edit function would be else where implemented
  scope :all_except, ->(user) { where.not(id: user) }
  validates :name,presence:true,length:{maximum:20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,length:{maximum:255}, format: {with: VALID_EMAIL_REGEX },
             uniqueness: {case_sensitive: false}

  validates_presence_of :role


  def set_default_role
    self.role ||= :student
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :enrollments, association_foreign_key: :user_id
  has_many :courses, through: :enrollments

  validates_presence_of  :password,length: { minimum: 6 }

end

