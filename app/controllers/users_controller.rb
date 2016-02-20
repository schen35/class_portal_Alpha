class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_except(current_user)
  end

  def show
    @user = User.find(params[:id])
    session[:user_id] = @user.id
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
    end

  def new
    @user = User.new
  end


  def edit
    @user = User.find(params[:id])
    session[:user_id] = @user.id
  end

  def create
    @user = User.new(add_user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to action: "index", notice:'New User has been successfully created!'}
        format.json { render :show, status: :created, location: @user}
      else
        format.html { render :new}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    session[:user_id] = @user.id
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'New user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'This user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_user
    @user = User.find(params[:id])
    session[:user_id] = @user.id
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  # Used for update user information
  def user_params
    params.require(:user).permit(:email, :role, :name)
  end

  def add_user_params
    params.require(:user).permit(:email, :name, :password, :role)
  end

end
