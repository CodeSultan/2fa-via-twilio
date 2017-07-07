
require "#{Rails.root}/lib/twilio_2fa_sms/confirmation_sender.rb"

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def settings

  end

  def edit
    @user = User.find(current_user)
    if !@user.verified?
      redirect_to @current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  ###### New Method ######

  def create
    @user = User.new(user_params)
    @user.tier_level = 0;
    @user.verified = 0;

    if @user.save
      session[:user_id] = @user.id
      tmp = true
      ConfirmationSender.send_confirmation_to(@user) if tmp.present?
      redirect_to register_verify_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password,
                                 :password_confirmation, :countryCode, :phoneNumber)
  end

end