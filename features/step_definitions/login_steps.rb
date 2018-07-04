Given("a valid user with email {string} and password {string}") do |string, string2|
  User.create!({:email => string, :password => string2, :password_confirmation => string2 })
end

When("I go to the login page") do
  visit  '/users/login_email'
end

When("I sign in with email {string} and password {string}") do |string, string2|
  fill_in "Email", :with => string
  fill_in "Password", :with => string2
  click_button "Log in"
end

Then("I should see {string}") do |string|
  expect(page).to have_content(string)
end
