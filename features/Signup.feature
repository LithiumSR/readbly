Feature: User sign up with email and password
    As a User
    I want to sign up 
    Such that i am registered

Scenario: User signs up unsuccessfully with email
    Given I am not logged in
    Given I am not registered
    When I go to the sign up page
    And I enter "user@test.com" as email
    And I enter "test" as password
    And I enter "test" as password confirmation
    Then I should be signed in
    When I return next time
    Then I should be already registered