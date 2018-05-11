When("I go to the sign up page") do
  visit  '/users/sign_up'
end

When("I sign up with email {string} and password {string}") do |string, string2|
  fill_in "Email", :with => string
  fill_in "Password", :with => string2
  fill_in "Password confirmation", :with => string2
  click_button "Sign up"
end