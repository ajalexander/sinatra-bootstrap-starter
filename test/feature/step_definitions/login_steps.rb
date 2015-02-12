Given(/^(?:|I )have logged in as "(.+)"$/) do |user|
  steps %Q{
    Given I am on the login page
    When I fill in "username" with "#{user}"
    And I fill in "password" with "test"
    And I press "Login"
  }
end