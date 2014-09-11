class UsersController < ApplicationController
  before_action :borrowers, only: [:index, :show]

  def index
    @users = User.borrowers.decorate
  end

  def show
    @user = User.borrowers.find(params[:id]).decorate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Registration successful. Congrats, you can use a keyboard.'
      if is_borrower?
        redirect_to session.delete(:last_page) || borrower_path
      else
        redirect_to session.delete(:last_page) || root_path
      end
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :nickname, :role)
  end

  def borrowers
    User.find_by(role: 'borrower')
  end
end
