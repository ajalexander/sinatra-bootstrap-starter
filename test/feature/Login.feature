Feature: Login

Scenario: Invalid account
  When I go to the login page
  And I fill in "username" with "invalid"
  And I fill in "password" with "secret"
  And I press "Login"
  Then I should be on the login page
  And I should see the message "Invalid login attempt"

Scenario: Invalid password
  When I go to the login page
  And I fill in "username" with "jdoe"
  And I fill in "password" with "secret"
  And I press "Login"
  Then I should be on the login page
  And I should see the message "Invalid login attempt"

Scenario: Successful login
  When I go to the login page
  And I fill in "username" with "jdoe"
  And I fill in "password" with "test"
  And I press "Login"
  Then I should be on the main page