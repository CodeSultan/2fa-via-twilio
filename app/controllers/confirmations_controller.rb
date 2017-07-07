
class ConfirmationsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
  end

  def create
    # @user = User.find( params[:user_id] )

    @user = User.find(session[:user_id])

    if @user.verification_code == params[:verification_code]
      # @user.confirm!
      session[:authenticated] = true
      @user.update(verified: 1)

      flash[:notice] = "Welcome #{@user.firstName} . The Adventure Begins!"
      redirect_to root_path
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end

  def resend_code
    @user = current_user
    tmp = true
    ConfirmationSender.send_confirmation_to(@user) if tmp.present?
    flash[:notice] = "Verification code re-sent"
    redirect_to register_verify_path
  end

end