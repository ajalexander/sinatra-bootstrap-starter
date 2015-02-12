Feature: Logout

Scenario: Unauthenticated
  When I go to logout
  Then I should be on the login page

Scenario: Authenticated
  Given I have logged in as "jdoe"
  When I go to logout
  Then I should be on the login page