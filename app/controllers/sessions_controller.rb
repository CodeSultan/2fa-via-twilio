class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user

      if user.tier_level?
        redirect_to dashboard_dashboard_path
      else
        redirect_to root_url
      end
    else
      # Create an error message.
      flash[:danger] = 'Email address or password is incorrect.' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end