Given(/^I wish to create a new filter$/) do
  @expected_class = MidasTouch::Filter
end

Given(/^I have a Filter$/) do
  @filter = MidasTouch::Filter.new(:test)
end

When(/^I register it with MidasTouch$/) do
  MidasTouch.register_filter(@filter)
end

Then(/^I can retrieve it by name$/) do
  assert_equal(@filter, MidasTouch.find_filter(:test))
end
