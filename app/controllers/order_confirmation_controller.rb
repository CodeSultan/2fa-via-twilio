
require "#{Rails.root}/lib/twilio_2fa_sms/order_confirmation_sender.rb"

class OrderConfirmationController < ApplicationController

  def new
    @user = User.find(session[:user_id])
    @user.update(selected_order_id: params[:selected_order])
    @order = Order.find(params[:selected_order])
    OrderConfirmationSender.send_confirmation_to(current_user, @order)
    flash[:notice] = "Your new order is not verified."
  end

  def create
    @user = User.find(session[:user_id])
    @order = Order.find(@user.selected_order_id)

    if @order.verification_code == params[:verification_code]
      # @user.confirm!
      @order.update(verified_order: 1)

      flash[:notice] = "Your new order is verified."
      redirect_to orders_path
    else
      flash[:notice] = "Verification code is incorrect."
      # render :new
    end
  end

end
