class SessionsController < ApplicationController
  def new
  end

  def create
    if (user = User.find_by(email: params[:email])) && user.authenticate(params[:password])
      session[:user_id] = user.id

      if is_borrower?
        redirect_to session.delete(:last_page) || borrower_path
      else
        redirect_to session.delete(:last_page) || root_path
      end
    else
      flash.now[:error] = 'Invalid username or password.'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
