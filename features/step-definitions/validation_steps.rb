Given(/^I wish to create a validation rule$/) do
  @expected_class = Midas::Validation
end

Given(/^I have a validation rule$/) do
  @rule = Midas::Validation.new(:example)
end

When(/^I register the with Midas$/) do
  Midas.register_validation(@rule)
end

Then(/^it can be retrieved with its name$/) do
  assert_equal(@rule, Midas.find_validation(:example))
end
