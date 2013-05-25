class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #Save Successful
      sign_in @user
      flash[:success] = "Welcome to MicroBlog!"
      redirect_to @user
    else
      #Errors!
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      #successful update
      flash[:success] = "Profile Updated!"
      sign_in @user
      redirect_to @user
    else
      #failed update
      
      render 'edit'
    end
  end
  

private

  def signed_in_user
    store_location
    redirect_to signin_url, notice: "Please Sign In." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end