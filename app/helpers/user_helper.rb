module UserHelper
  def user_dashboard
    if current_user.role == "borrower"
      borrower_path
    else
      lender_path
    end
  end
end
