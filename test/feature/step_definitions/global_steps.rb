Given(/^(?:|I )am on (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^(?:|I )go to (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^(?:|I )press "([^\"]*)"$/) do |button|
  click_button(button)
end

When(/^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

Then(/^(?:|I )should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then(/^(?:|I )should see the message "(.*?)"$/) do |message|
  find('.alert').should have_content(message)
end

Then(/^"([^\"]*)" should be "([^\"]*)"$/) do |field, value|
  find_field(field).value.should eq(value)
end