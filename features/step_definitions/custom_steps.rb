Given /^I am logged in as (.*) with passsword (.*)$/ do |email, password|
  user = create_or_find_user(email, password)
  visit path_to("the login page")
  fill_in("Email", :with => user.email )
  fill_in("Password", :with => user.password )
  click_button("Sign in")
end

When /^I fill in "([^"]*)" of the "([^"]*)" (\d+) with "([^"]*)" for the "([^"]*)"$/ do |nested_field, field, number, value, clazz|
    name = "#{clazz.gsub(" ", "_").downcase}_" + field.gsub(" ", "_").downcase.pluralize + "_attributes_#{number}_#{nested_field.gsub(" ", "_").downcase}"
    When %{I fill in "#{name}" with "#{value}"}
end

When /^I fill in the following of the "([^"]*)" (\d+) for the "([^"]*)":$/ do |field, number, clazz, table|
    clazz = clazz.gsub(" ", "_").downcase
    field = field.gsub(" ", "_").downcase.pluralize
    table.rows_hash.each do |nested_field, value|
      name = "#{clazz}_" + field + "_attributes_#{number}_#{nested_field.gsub(" ", "_").downcase}"
      When %{I fill in "#{name}" with "#{value}"}
    end
end


When /^I fill in the following of the "([^"]*)" for the "([^"]*)":$/ do |field, clazz, table|
    clazz = clazz.gsub(" ", "_").downcase
    field = field.gsub(" ", "_").downcase
    table.rows_hash.each do |nested_field, value|
      name = "#{clazz}_" + field + "_attributes_#{nested_field.gsub(" ", "_").downcase}"
      When %{I fill in "#{name}" with "#{value}"}
    end
end

When /^I select "([^"]*)" from the "([^"]*)" of the "([^"]*)" (\d+) for the "([^"]*)"$/ do |value, nested_field, field, number, clazz|
  name = "#{clazz.gsub(" ", "_").downcase}_" + field.gsub(" ", "_").downcase.pluralize + "_attributes_#{number}_#{nested_field.gsub(" ", "_").downcase}"
  begin
    When %{I select "#{value}" from "#{name}"}
  rescue
    name << "_id"
    When %{I select "#{value}" from "#{name}"}
  end
end

When /^I select "([^"]*)" from the "([^"]*)" of the "([^"]*)" for the "([^"]*)"$/ do |value, nested_field, field, clazz|
  name = "#{clazz.gsub(" ", "_").downcase}_" + field.gsub(" ", "_").downcase + "_attributes_#{nested_field.gsub(" ", "_").downcase}"
  begin
    When %{I select "#{value}" from "#{name}"}
  rescue
    name << "_id"
    When %{I select "#{value}" from "#{name}"}
  end
end

When /^I choose "([^"]*)" from the "([^"]*)" of the "([^"]*)" for the "([^"]*)"$/ do |value, nested_field, field, clazz|
  name = "#{clazz.gsub(" ", "_").downcase}_" + field.gsub(" ", "_").downcase + "_attributes_#{nested_field.gsub(" ", "_").downcase}_#{value}"
  When %{I choose "#{name.downcase}"}
end
