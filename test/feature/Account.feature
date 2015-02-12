Feature: Account

Scenario: Unauthenticated
  When I go to the account page
  Then I should be on the login page
  And I should see the message "Invalid session. Please login again."

Scenario: Authenticated
  Given I have logged in as "jdoe"
  When I go to the account page
  Then I should be on the account page

Scenario: Display Current Settings
  Given I have logged in as "jdoe"
  When I go to the account page
  Then "email_address" should be "jdoe@test.com"

Scenario: Change Settings - Missing Email Address
  Given I have logged in as "jdoe"
  When I go to the account page
  And I fill in "email_address" with ""
  And I press "Save"
  Then I should be on the account page
  And I should see the message "email_address is not present"

Scenario: Change Settings - Successful Change
  Given I have logged in as "jdoe"
  When I go to the account page
  And I fill in "email_address" with "new-address@test.com"
  And I press "Save"
  Then I should be on the account page
  And "email_address" should be "new-address@test.com"
  And I should see the message "Account settings updated"

Scenario: Change Password - Incorrect Password
  Given I have logged in as "jdoe"
  When I go to the account page
  And I fill in "current_password" with "invalid"
  And I press "Change Password"
  Then I should be on the account page
  And I should see the message "Incorrect password"

Scenario: Change Password - Unmatched Passwords
  Given I have logged in as "jdoe"
  When I go to the account page
  And I fill in "current_password" with "test"
  And I fill in "new_password" with "password1"
  And I fill in "new_password_confirmation" with "password2"
  And I press "Change Password"
  Then I should be on the account page
  And I should see the message "The new passwords don't match"

Scenario: Change Password - Successful Change
  Given I have logged in as "jdoe"
  When I go to the account page
  And I fill in "current_password" with "test"
  And I fill in "new_password" with "password"
  And I fill in "new_password_confirmation" with "password"
  And I press "Change Password"
  Then I should be on the account page
  And I should see the message "Password updated"