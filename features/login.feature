 Feature: User tries to login but fails 
 Scenario: User signs in unsuccessfully with email and password
    Given I am not logged in
    And I am a user named "foo" with an email "user@test.com" and password "please"
    When I go to the sign in page
    And I sign in as "user@test.com/please"
    Then I should not be signed in
    When I return next time
    Then I should not be already signed in