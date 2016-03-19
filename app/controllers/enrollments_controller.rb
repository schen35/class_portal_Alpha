class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]


  # GET /enrollments
  # GET /enrollments.json
  def index
    @courses= Course.all
    @users = User.all
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
    @courses= Course.all
    @users = User.all
  end

  # GET /enrollments/index_instructor
  def index_instructor
    @courses= Course.all
    @users = User.all
    @user_id = current_user
    @enrollments = Enrollment.all
  end

  # GET /enrollments/index_student
  def index_student
    @courses= Course.all
    @users = User.all
    @user_id = current_user
    @enrollments = Enrollment.all
  end

  # GET /enrollments/new
  def new

    @instructors = User.find_by_sql('SELECT * FROM users WHERE role=1')
    @students = User.find_by_sql('SELECT * FROM users WHERE role=0')
    @courses= Course.all

    if can? :do_as_student, :all
    @users = User.all
    @course_id = session[:current_course]
    # select course with course ID
    @course_find = @courses.where('"courses"."id" = ?', "#{@course_id}")
    @course_find.each do |course|
      @instructor_name = course.Instructor
      # select instructor with instructor NAME
      @user_find = @users.where('"users"."name" = ?', "#{@instructor_name}")
      @user_find.each do |user|
        @instructor_id = user.id
        session[:current_course_instructor_id]= @instructor_id
      end
    end
    @user_id = current_user
    @instructor_id = session[:current_course_instructor_id]
    end

    @enrollment = Enrollment.new
  end


  # GET /enrollments/1/edit
  def edit
    if can? :do_as_student, :all
      @courses= Course.all
      @users = User.all
      @course_id = session[:current_course]
      # select course with course ID
      @course_find = @courses.where('"courses"."id" = ?', "#{@course_id}")
      @course_find.each do |course|
        @instructor_name = course.Instructor
        # select instructor with instructor NAME
        @user_find = @users.where('"users"."name" = ?', "#{@instructor_name}")
        @user_find.each do |user|
          @instructor_id = user.id
          session[:current_course_instructor_id]= @instructor_id
        end
      end
      @user_id = current_user
      @instructor_id = session[:current_course_instructor_id]
    end
  end



  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)
    @course_id = params[:course_id_param]
    respond_to do |format|
      if @enrollment.save
        if can? :do_as_student, :all
          format.html { redirect_to action: "index_student"  }
        else if can? :do_as_instructor, :all
               format.html { redirect_to action: "index_instructor"  }
             else
        format.html { redirect_to action: "index"  }
               end
        end
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    @enrollment = Enrollment.find(params[:id])
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        if can? :do_as_student, :all
          format.html { redirect_to action: "index_student"  }
        else if can? :do_as_instructor, :all
               format.html { redirect_to action: "index_instructor"  }
             else
        format.html { redirect_to action: "index" }
             end
        end
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      if can? :do_as_student, :all
        format.html { redirect_to action: "index_student"  }
      else if can? :do_as_instructor, :all
             format.html { redirect_to action: "index_instructor"  }
           else
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
           end
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:student_id, :instructor_id, :course_id, :grade, :material, :admission)
    end
end
