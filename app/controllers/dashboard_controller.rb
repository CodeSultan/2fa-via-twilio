
class DashboardController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :logged_in_user
  before_action :correct_user
  before_action :admin_user,     only: :destroy

  def users
    # @users = User.all
    @users = User.paginate(page: params[:page])
  end

  def orders
    @orders = Order.all
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end
  #
  # # Confirms the correct user.
  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  # end

  def correct_user

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to dashboard_users_path
  end

  private

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
