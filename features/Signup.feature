Feature: User sign up with email and password
    As a User
    I want to sign up 
    Such that i am registered

Scenario: User signs up successfully with email
    When I go to the sign up page
    And I sign up with email "test_sign_up@test.com" and password "test123"
    Then I should see "Welcome! You have signed up successfully."