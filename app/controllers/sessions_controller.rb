class SessionsController < ApplicationController
  def new
  end

  def create
    if (user = User.find_by(email: params[:email])) && user.authenticate(params[:password])
      session[:user_id] = user.id

      if is_borrower?
<<<<<<< HEAD
        redirect_to session.delete(:last_page) || borrower_orders_path
=======
        redirect_to session.delete(:last_page) || admin_items_path
>>>>>>> f300a8834c638d83f27826baa9ffe4fe35e5b631
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
