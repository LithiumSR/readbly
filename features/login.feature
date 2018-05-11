Feature: 
    As a User
    I want to sign in 
    
Scenario: User signs in successfully with email and password
    Given a valid user with email "test_sign_in@test.com" and password "test123"
    When I go to the login page
    And I sign in with email "test_sign_in@test.com" and password "test123"
    Then I should see "Signed in successfully."