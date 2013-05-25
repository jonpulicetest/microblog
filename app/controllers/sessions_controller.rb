class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #success
      sign_in user
      redirect_back_or user
    else
      #failure
      flash.now[:error] = "Invalid Username/Password Combinaion"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
