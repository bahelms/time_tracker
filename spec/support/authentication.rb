def signup_with(options)
  fill_in "Username", with: "Bob"
  fill_in "Email", with: options[:email]
  fill_in "Password", with: options[:password]

  confirm = options[:confirm] ? options[:confirm] : options[:password]
  fill_in "Password confirmation", with: confirm
  click_button "Sign Up"
end

def sign_in_with(options)
  fill_in "Email", with: options[:email]
  fill_in "Password", with: options[:password]
  click_button "Sign In"
end
