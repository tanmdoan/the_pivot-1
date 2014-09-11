def register(first_name: 'Gen',
             last_name: 'Casagrande',
             email: 'yourmom123@aol.com',
             password: '123',
             password_confirmation: '123',
             nickname: 'gen')

  visit root_path
  click_on('Register')

  fill_in "First name",            with: first_name
  fill_in "Last name",             with: last_name
  fill_in "Email",                 with: email
  fill_in "Password" ,             with: password
  fill_in "Password confirmation", with: password_confirmation
  fill_in 'Nickname',              with: nickname
  click_on "Create User"
end


def login(email: 'yourmom123@aol.com', password: '123')
  visit login_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Login'
end

def register_as_borrower(first_name: 'Gen',
                      last_name: 'Casagrande',
                      email: 'yourdad123@aol.com',
                      password: '123',
                      password_confirmation: '123')

  register(first_name: first_name, last_name: last_name, email: email, password: password, password_confirmation: password_confirmation)
end

def register_as_lender(first_name: 'Duder',
                      last_name: 'Casagrande',
                      email: '123@aol.com',
                      password: '123',
                      password_confirmation: '123')

  visit root_path
  click_on("Register")

  fill_in "First name",            with: first_name
  fill_in "Last name",             with: last_name
  fill_in "Email",                 with: email
  fill_in "Password" ,             with: password
  fill_in "Password confirmation", with: password_confirmation
  choose  "Lender"
  click_on "Create User"
end


def login_as_lender(email: '123@aol.com', password: '123')
  login(email: email, password: password)
end


def login_as_borrower(email: 'yourdad123@aol.com', password: '123')
  login(email: email, password: password)
end

def register_and_login_as_borrower
  register_as_borrower
  login_as_borrower
end

def register_and_login_as_a_lender
  register_as_lender
  login_as_lender
end

def format_date(date)
  date.to_time.strftime("%m/%d/%Y")
end

def format_time(date)
  date.to_time.strftime("%I:%M %p")
end
