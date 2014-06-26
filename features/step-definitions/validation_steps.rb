Given(/^I wish to create a validation rule$/) do
  @expected_class = MidasTouch::Validation
end

Given(/^I have a validation rule$/) do
  @rule = MidasTouch::Validation.new(:example)
end

When(/^I register the with MidasTouch$/) do
  MidasTouch.register_validation(@rule)
end

Then(/^it can be retrieved with its name$/) do
  assert_equal(@rule, MidasTouch.find_validation(:example))
end
