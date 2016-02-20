class SuperadminsController < UsersController
  before_action :authenticate_user!
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'This user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
